import 'package:core/core.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

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
              onChanged: (value) {
                context.read<SearchBloc>().add(OnQueryChanged(value));
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
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  final data = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = data[index];
                        return MovieTvCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MovieDetailPage.routeName,
                              arguments: movie.id,
                            );
                          },
                          title: movie.title ?? '-',
                          overview: movie.overview ?? '-',
                          posterPath: '$baseImageUrl/${movie.posterPath}',
                        );
                      },
                      itemCount: data.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(child: Text(state.message)),
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
