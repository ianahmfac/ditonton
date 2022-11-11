import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../provider/movie_list_notifier.dart';
import '../widgets/app_drawer.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_list_widget.dart';
import '../widgets/home_sub_heading.dart';
import '../widgets/state_widget_builder.dart';
import 'home_tv_page.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'search_page.dart';
import 'top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
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
        onTvClick: () => Navigator.pushReplacementNamed(context, HomeTvPage.ROUTE_NAME),
      ),
      appBar: HomeAppBar(
        title: 'Ditonton - Movies',
        onSearch: () => Navigator.pushNamed(context, SearchPage.ROUTE_NAME),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSubHeading(title: 'Now Playing'),
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
                onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
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
                onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
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

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return HomeListWidget(
            onTap: () {
              Navigator.pushNamed(context, MovieDetailPage.ROUTE_NAME, arguments: movie.id);
            },
            posterPath: '$BASE_IMAGE_URL/${movie.posterPath}',
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
