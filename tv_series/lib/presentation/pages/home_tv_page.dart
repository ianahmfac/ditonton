import 'package:core/presentation/widgets/app_drawer.dart';
import 'package:core/presentation/widgets/home_app_bar.dart';
import 'package:core/presentation/widgets/home_list_widget.dart';
import 'package:core/presentation/widgets/home_sub_heading.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_top_rated_bloc.dart';

import '../../domain/entities/tv_series.dart';
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
    Future.microtask(() {
      context.read<HomeTvNowPlayingBloc>().add(GetHomeNowPlayingTv());
      context.read<HomeTvPopularBloc>().add(GetHomeTvPopular());
      context.read<HomeTvTopRatedBloc>().add(GetHomeTvTopRated());
    });
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
              BlocBuilder<HomeTvNowPlayingBloc, HomeTvNowPlayingState>(
                builder: (context, state) {
                  if (state is HomeTvNowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeTvNowPlayingLoaded) {
                    final nowPlayingTv = state.nowPlayingTv;
                    return _tvSeriesList(nowPlayingTv);
                  } else if (state is HomeTvNowPlayingError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  }
                  return Container();
                },
              ),
              HomeSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, PopularTvPage.routeName),
              ),
              BlocBuilder<HomeTvPopularBloc, HomeTvPopularState>(
                builder: (context, state) {
                  if (state is HomeTvPopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeTvPopularLoaded) {
                    final popularTv = state.popularTv;
                    return _tvSeriesList(popularTv);
                  } else if (state is HomeTvPopularError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  }
                  return Container();
                },
              ),
              HomeSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedTvPage.routeName),
              ),
              BlocBuilder<HomeTvTopRatedBloc, HomeTvTopRatedState>(
                builder: (context, state) {
                  if (state is HomeTvTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeTvTopRatedLoaded) {
                    final topRatedTv = state.topRatedTv;
                    return _tvSeriesList(topRatedTv);
                  } else if (state is HomeTvTopRatedError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  }
                  return Container();
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
