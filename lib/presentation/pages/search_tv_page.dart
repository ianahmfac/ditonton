import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../injection.dart';
import '../provider/tv_search_notifier.dart';
import '../widgets/movie_tv_card.dart';
import '../widgets/state_widget_builder.dart';
import 'tv_detail_page.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<TvSearchNotifier>(),
      child: _SearchTvPageData(),
    );
  }
}

class _SearchTvPageData extends StatefulWidget {
  _SearchTvPageData({Key? key}) : super(key: key);

  @override
  State<_SearchTvPageData> createState() => __SearchTvPageDataState();
}

class __SearchTvPageDataState extends State<_SearchTvPageData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
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
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
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
                                TvDetailPage.ROUTE_NAME,
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
