import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import 'movie_detail_page.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TopRatedMovieBloc>().add(GetTopRatedMoviesEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.topRatedMovies[index];
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
                itemCount: state.topRatedMovies.length,
              );
            } else if (state is TopRatedMovieError) {
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
