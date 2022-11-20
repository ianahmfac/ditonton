part of 'home_movie_now_playing_bloc.dart';

abstract class HomeMovieNowPlayingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetHomeNowPlayingMovies extends HomeMovieNowPlayingEvent {}
