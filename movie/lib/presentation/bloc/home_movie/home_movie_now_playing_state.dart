part of 'home_movie_now_playing_bloc.dart';

abstract class HomeMovieNowPlayingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeMovieNowPlayingInitial extends HomeMovieNowPlayingState {}

class HomeMovieNowPlayingLoading extends HomeMovieNowPlayingState {}

class HomeMovieNowPlayingLoaded extends HomeMovieNowPlayingState {
  final List<Movie> nowPlayingMovies;
  HomeMovieNowPlayingLoaded({
    required this.nowPlayingMovies,
  });

  @override
  List<Object?> get props => [nowPlayingMovies];
}

class HomeMovieNowPlayingError extends HomeMovieNowPlayingState {
  final String message;
  HomeMovieNowPlayingError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
