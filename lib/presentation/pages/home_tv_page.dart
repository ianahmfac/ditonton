import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import '../provider/tv_series_list_notifier.dart';
import '../widgets/app_drawer.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_list_widget.dart';
import '../widgets/home_sub_heading.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_series';
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeriesListNotifier>().fetchNowPlayingTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        onMovieClick: () => Navigator.pushReplacementNamed(context, '/home'),
        onTvClick: () => Navigator.pop(context),
      ),
      appBar: HomeAppBar(title: 'Ditonton - Tv Series'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSubHeading(title: 'Now Airing'),
              Consumer<TvSeriesListNotifier>(
                builder: (context, notifier, child) {
                  final state = notifier.nowPlayingState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Error) {
                    return Text(notifier.message);
                  } else if (state == RequestState.Loaded) {
                    final nowPlayings = notifier.nowPlayings;
                    return _tvSeriesList(nowPlayings);
                  }
                  return SizedBox();
                },
              ),
              HomeSubHeading(
                title: 'Popular',
                onTap: () {},
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
            onTap: () {},
            posterPath: tvSeries.posterPath,
          );
        },
        itemCount: listTvSeries.length,
      ),
    );
  }
}
