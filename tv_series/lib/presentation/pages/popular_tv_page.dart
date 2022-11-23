import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_bloc.dart';

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
    Future.microtask(() => context.read<PopularTvBloc>().add(GetPopularTvEvent()));
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
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          buildWhen: (previous, current) => current is! PopularTvLoadMore,
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvLoaded) {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () {
                  context.read<PopularTvBloc>().add(GetPopularTvEvent());
                  _refreshController.refreshCompleted();
                },
                onLoading: () {
                  context.read<PopularTvBloc>().add(GetPopularTvEvent(isLoadMore: true));
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
            } else if (state is PopularTvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
