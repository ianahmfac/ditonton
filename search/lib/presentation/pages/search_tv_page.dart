import 'package:core/core.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:core/presentation/widgets/state_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tv_search_notifier.dart';

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
                context.read<TvSearchNotifier>().fetchTvSearch(query);
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
            Consumer<TvSearchNotifier>(
              builder: (context, data, child) {
                final state = data.state;
                return StateWidgetBuilder(
                  state: state,
                  loadedWidget: (context) {
                    final result = data.searchResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = data.searchResult[index];
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
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
