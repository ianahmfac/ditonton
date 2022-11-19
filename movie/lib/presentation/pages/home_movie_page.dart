import 'package:core/core.dart';
import 'package:core/presentation/widgets/app_drawer.dart';
import 'package:core/presentation/widgets/home_app_bar.dart';
import 'package:core/presentation/widgets/home_list_widget.dart';
import 'package:core/presentation/widgets/home_sub_heading.dart';
import 'package:core/presentation/widgets/state_widget_builder.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';

import '../../domain/entities/movie.dart';
import '../bloc/movie_list_notifier.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<MovieListNotifier>(context, listen: false)
      ..fetchNowPlayingMovies()
      ..fetchPopularMovies()
      ..fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        onMovieClick: () => Navigator.pop(context),
        onTvClick: () => Navigator.pushReplacementNamed(context, HomeTvPage.routeName),
      ),
      appBar: HomeAppBar(
        title: 'Ditonton - Movies',
        onSearch: () => Navigator.pushNamed(context, searchRoute),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeSubHeading(title: 'Now Playing'),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                return StateWidgetBuilder(
                  state: state,
                  loadedWidget: (context) {
                    return MovieList(data.nowPlayingMovies);
                  },
                  errorMessage: data.message,
                );
              }),
              HomeSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                return StateWidgetBuilder(
                  state: state,
                  loadedWidget: (context) {
                    return MovieList(data.popularMovies);
                  },
                  errorMessage: data.message,
                );
              }),
              HomeSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                return StateWidgetBuilder(
                  state: state,
                  loadedWidget: (context) {
                    return MovieList(data.topRatedMovies);
                  },
                  errorMessage: data.message,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return HomeListWidget(
            onTap: () {
              Navigator.pushNamed(context, MovieDetailPage.routeName, arguments: movie.id);
            },
            posterPath: '$baseImageUrl/${movie.posterPath}',
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
