part of 'home_movie_top_rated_bloc.dart';

abstract class HomeMovieTopRatedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeMovieTopRatedInitial extends HomeMovieTopRatedState {}

class HomeMovieTopRatedLoading extends HomeMovieTopRatedState {}

class HomeMovieTopRatedLoaded extends HomeMovieTopRatedState {
  final List<Movie> topRatedMovies;
  HomeMovieTopRatedLoaded({
    required this.topRatedMovies,
  });

  @override
  List<Object?> get props => [topRatedMovies];
}

class HomeMovieTopRatedError extends HomeMovieTopRatedState {
  final String message;
  HomeMovieTopRatedError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
