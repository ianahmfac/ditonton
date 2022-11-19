import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:core/presentation/widgets/state_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../bloc/popular_tv_notifier.dart';
import 'tv_detail_page.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTvPage({super.key});

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    Future.microtask(() => context.read<PopularTvNotifier>().fetchPopularTvSeries());
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            return StateWidgetBuilder(
              state: data.state,
              loadedWidget: (context) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () async {
                    await context.read<PopularTvNotifier>().fetchPopularTvSeries();
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    final notifier = context.read<PopularTvNotifier>();
                    await notifier.fetchPopularTvSeries(init: false);
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
