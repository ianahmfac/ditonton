import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../provider/top_rated_tv_notifier.dart';
import '../widgets/movie_tv_card.dart';
import '../widgets/state_widget_builder.dart';
import 'tv_detail_page.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';

  const TopRatedTvPage({super.key});

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    Future.microtask(() => context.read<TopRatedTvNotifier>().fetchTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvNotifier>(
          builder: (context, data, child) {
            return StateWidgetBuilder(
              state: data.state,
              loadedWidget: (context) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () async {
                    await context.read<TopRatedTvNotifier>().fetchTopRatedTvSeries();
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    final notifier = context.read<TopRatedTvNotifier>();
                    await notifier.fetchTopRatedTvSeries(init: false);
                    if (notifier.state == RequestState.loaded) {
                      _refreshController.loadComplete();
                    } else {
                      _refreshController.loadFailed();
                    }
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = data.tvSeries[index];
                      return MovieTvCard(
                        onTap: () => Navigator.pushNamed(
                          context,
                          TvDetailPage.routeName,
                          arguments: tv.id,
                        ),
                        title: tv.name,
                        overview: tv.overview,
                        posterPath: tv.posterPath ?? '',
                      );
                    },
                    itemCount: data.tvSeries.length,
                  ),
                );
              },
              errorMessage: data.message,
            );
          },
        ),
      ),
    );
  }
}
