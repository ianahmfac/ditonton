part of 'home_movie_popular_bloc.dart';

abstract class HomeMoviePopularState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeMoviePopularInitial extends HomeMoviePopularState {}

class HomeMoviePopularLoading extends HomeMoviePopularState {}

class HomeMoviePopularLoaded extends HomeMoviePopularState {
  final List<Movie> popularMovies;
  HomeMoviePopularLoaded({
    required this.popularMovies,
  });
  @override
  List<Object?> get props => [popularMovies];
}

class HomeMoviePopularError extends HomeMoviePopularState {
  final String message;
  HomeMoviePopularError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
