import 'package:core/core.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

class SearchTvPage extends StatefulWidget {
  static const routeName = '/search-tv';
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  State<SearchTvPage> createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              onSubmitted: (query) {
                context.read<SearchTvBloc>().add(OnTvQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc, SearchTvState>(
              builder: (context, state) {
                if (state is SearchTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvError) {
                  return Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  );
                } else if (state is SearchTvHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return MovieTvCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              TvDetailPage.routeName,
                              arguments: tv.id,
                            );
                          },
                          title: tv.name,
                          overview: tv.overview,
                          posterPath: tv.posterPath ?? '',
                        );
                      },
                      itemCount: result.length,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
