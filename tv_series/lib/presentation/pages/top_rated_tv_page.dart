import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rate_tv_bloc.dart';

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
    Future.microtask(() => context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
            buildWhen: (previous, current) => current is! TopRatedTvLoadMore,
            builder: (context, state) {
              if (state is TopRateTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvLoaded) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () {
                    context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent());
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () {
                    context.read<TopRatedTvBloc>().add(GetTopRatedTvEvent(isLoadMore: true));
                    _refreshController.loadComplete();
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.tvSeries[index];
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
                    itemCount: state.tvSeries.length,
                  ),
                );
              }
              return Container();
            },
          )),
    );
  }
}
