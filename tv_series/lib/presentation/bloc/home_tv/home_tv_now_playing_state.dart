part of 'home_tv_now_playing_bloc.dart';

abstract class HomeTvNowPlayingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeTvNowPlayingInitial extends HomeTvNowPlayingState {}

class HomeTvNowPlayingLoading extends HomeTvNowPlayingState {}

class HomeTvNowPlayingLoaded extends HomeTvNowPlayingState {
  final List<TvSeries> nowPlayingTv;
  HomeTvNowPlayingLoaded({
    required this.nowPlayingTv,
  });

  @override
  List<Object?> get props => [nowPlayingTv];
}

class HomeTvNowPlayingError extends HomeTvNowPlayingState {
  final String message;
  HomeTvNowPlayingError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
