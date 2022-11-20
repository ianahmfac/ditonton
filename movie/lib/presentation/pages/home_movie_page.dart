import 'package:core/core.dart';
import 'package:core/presentation/widgets/app_drawer.dart';
import 'package:core/presentation/widgets/home_app_bar.dart';
import 'package:core/presentation/widgets/home_list_widget.dart';
import 'package:core/presentation/widgets/home_sub_heading.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc_export.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';

import '../../domain/entities/movie.dart';
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
    Future.microtask(() {
      context.read<HomeMovieNowPlayingBloc>().add(GetHomeNowPlayingMovies());
      context.read<HomeMoviePopularBloc>().add(GetHomeMoviePopular());
      context.read<HomeMovieTopRatedBloc>().add(GetHomeMovieTopRated());
    });
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
              BlocBuilder<HomeMovieNowPlayingBloc, HomeMovieNowPlayingState>(
                builder: (context, state) {
                  if (state is HomeMovieNowPlayingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeMovieNowPlayingLoaded) {
                    return MovieList(state.nowPlayingMovies);
                  } else if (state is HomeMovieNowPlayingError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  }
                  return const SizedBox();
                },
              ),
              HomeSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<HomeMoviePopularBloc, HomeMoviePopularState>(
                builder: (context, state) {
                  if (state is HomeMoviePopularLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeMoviePopularLoaded) {
                    return MovieList(state.popularMovies);
                  } else if (state is HomeMoviePopularError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  }
                  return const SizedBox();
                },
              ),
              HomeSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<HomeMovieTopRatedBloc, HomeMovieTopRatedState>(
                builder: (context, state) {
                  if (state is HomeMovieTopRatedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeMovieTopRatedLoaded) {
                    return MovieList(state.topRatedMovies);
                  } else if (state is HomeMovieTopRatedError) {
                    return Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    );
                  }
                  return const SizedBox();
                },
              ),
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
