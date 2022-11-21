part of 'tv_detail_watchlist_bloc.dart';

abstract class TvDetailWatchlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvDetailWatchlistInitial extends TvDetailWatchlistState {}

class TvWatchlistStatus extends TvDetailWatchlistState {
  final bool isAddToWatchlist;

  TvWatchlistStatus(this.isAddToWatchlist);

  @override
  List<Object?> get props => [isAddToWatchlist];
}

class TvWatchlistAddRemove extends TvDetailWatchlistState {
  final String message;

  TvWatchlistAddRemove(this.message);

  @override
  List<Object?> get props => [message];
}
