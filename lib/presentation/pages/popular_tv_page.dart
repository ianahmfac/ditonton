import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/state_enum.dart';
import '../provider/popular_tv_notifier.dart';
import '../widgets/movie_tv_card.dart';
import '../widgets/state_widget_builder.dart';
import 'tv_detail_page.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
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
        title: Text('Popular TV Series'),
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
                    if (notifier.state == RequestState.Loaded) {
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
                          TvDetailPage.ROUTE_NAME,
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
