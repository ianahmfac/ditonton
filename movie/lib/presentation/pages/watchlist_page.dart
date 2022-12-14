import 'package:core/common/utils.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

import 'movie_detail_page.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(GetWatchlistMovieEvent());
      context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchlistMovieEvent());
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const TabBar(tabs: [
                Tab(text: 'Movies'),
                Tab(text: 'Tv Series'),
              ]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TabBarView(
                    children: [
                      _buildMovieWatchlist(),
                      _buildTvWatchList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieWatchlist() {
    return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
      builder: (context, state) {
        if (state is WatchlistMovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistMovieLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = state.watchlistMovies[index];
              return MovieTvCard(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.routeName,
                    arguments: movie.id,
                  );
                },
                title: movie.title ?? '-',
                overview: movie.overview ?? '-',
                posterPath: '$baseImageUrl/${movie.posterPath}',
              );
            },
            itemCount: state.watchlistMovies.length,
          );
        } else if (state is WatchlistMovieError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildTvWatchList() {
    return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
      builder: (context, state) {
        if (state is WatchlistTvLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistTvLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final tv = state.tvSeries[index];
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
            itemCount: state.tvSeries.length,
          );
        } else if (state is WatchlistTvError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
