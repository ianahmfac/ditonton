import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/utils.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../provider/watchlist_tv_notifier.dart';
import '../widgets/movie_tv_card.dart';
import '../widgets/state_widget_builder.dart';
import 'movie_detail_page.dart';
import 'tv_detail_page.dart';

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
      context.read<WatchlistMovieNotifier>().fetchWatchlistMovies();
      context.read<WatchListTvNotifier>().fetchWatchList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieNotifier>().fetchWatchlistMovies();
    context.read<WatchListTvNotifier>().fetchWatchList();
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
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.watchlistState == RequestState.loaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = data.watchlistMovies[index];
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
            itemCount: data.watchlistMovies.length,
          );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  Widget _buildTvWatchList() {
    return Consumer<WatchListTvNotifier>(
      builder: (context, data, child) {
        final state = data.state;
        return StateWidgetBuilder(
          state: state,
          loadedWidget: (context) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = data.watchlists[index];
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
              itemCount: data.watchlists.length,
            );
          },
          errorMessage: data.message,
        );
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
