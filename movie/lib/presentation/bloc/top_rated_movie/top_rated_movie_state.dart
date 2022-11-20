part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> topRatedMovies;
  TopRatedMovieLoaded({
    required this.topRatedMovies,
  });

  @override
  List<Object?> get props => [topRatedMovies];
}

class TopRatedMovieError extends TopRatedMovieState {
  final String message;
  TopRatedMovieError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
