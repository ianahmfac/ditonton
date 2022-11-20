part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailWatchlistInitial extends MovieDetailWatchlistState {}

class MovieWatchlistStatus extends MovieDetailWatchlistState {
  final bool isAddToWatchlist;

  MovieWatchlistStatus(this.isAddToWatchlist);

  @override
  List<Object?> get props => [isAddToWatchlist];
}

class MovieWatchlistAddRemove extends MovieDetailWatchlistState {
  final String message;

  MovieWatchlistAddRemove(this.message);

  @override
  List<Object?> get props => [message];
}
