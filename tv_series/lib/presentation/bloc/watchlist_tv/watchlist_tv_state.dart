part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvLoaded extends WatchlistTvState {
  final List<TvSeries> tvSeries;
  WatchlistTvLoaded({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class WatchlistTvError extends WatchlistTvState {
  final String message;
  WatchlistTvError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
