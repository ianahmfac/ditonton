part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> popularMovies;
  PopularMovieLoaded({
    required this.popularMovies,
  });

  @override
  List<Object?> get props => [popularMovies];
}

class PopularMovieError extends PopularMovieState {
  final String message;
  PopularMovieError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
