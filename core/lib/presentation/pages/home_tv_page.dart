import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/tv_series.dart';
import '../provider/tv_series_list_notifier.dart';
import '../widgets/app_drawer.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_list_widget.dart';
import '../widgets/home_sub_heading.dart';
import '../widgets/state_widget_builder.dart';
import 'now_playing_tv_page.dart';
import 'popular_tv_page.dart';
import 'top_rated_tv_page.dart';
import 'tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = '/tv_series';
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeriesListNotifier>()
        ..fetchNowPlayingTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        onMovieClick: () => Navigator.pushReplacementNamed(context, '/home'),
        onTvClick: () => Navigator.pop(context),
      ),
      appBar: HomeAppBar(
        title: 'Ditonton - Tv Series',
        onSearch: () => Navigator.pushNamed(context, searchTvRoute),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSubHeading(
                title: 'Now Airing',
                onTap: () => Navigator.pushNamed(context, NowPlayingTvPage.routeName),
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, notifier, child) {
                  final state = notifier.nowPlayingState;
                  return StateWidgetBuilder(
                    state: state,
                    loadedWidget: (context) {
                      final nowPlayings = notifier.nowPlayings;
                      return _tvSeriesList(nowPlayings);
                    },
                    errorMessage: notifier.message,
                  );
                },
              ),
              HomeSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, PopularTvPage.routeName),
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, notifier, child) {
                  final state = notifier.popularState;
                  return StateWidgetBuilder(
                    state: state,
                    loadedWidget: (context) {
                      final populars = notifier.populars;
                      return _tvSeriesList(populars);
                    },
                    errorMessage: notifier.message,
                  );
                },
              ),
              HomeSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedTvPage.routeName),
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, notifier, child) {
                  final state = notifier.topRatedState;
                  return StateWidgetBuilder(
                    state: state,
                    loadedWidget: (context) {
                      final topRates = notifier.topRates;
                      return _tvSeriesList(topRates);
                    },
                    errorMessage: notifier.message,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _tvSeriesList(List<TvSeries> listTvSeries) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = listTvSeries[index];
          return HomeListWidget(
            onTap: () => Navigator.pushNamed(
              context,
              TvDetailPage.routeName,
              arguments: tvSeries.id,
            ),
            posterPath: tvSeries.posterPath,
          );
        },
        itemCount: listTvSeries.length,
      ),
    );
  }
}
