part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NowPlayingTvInitial extends NowPlayingTvState {}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<TvSeries> tvSeries;
  NowPlayingTvLoaded({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;
  NowPlayingTvError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
