part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistState {}

class MovieDetailWatchlistInitial extends MovieDetailWatchlistState {}

class MovieWatchlistStatus extends MovieDetailWatchlistState {
  final bool isAddToWatchlist;
  MovieWatchlistStatus({
    required this.isAddToWatchlist,
  });
}

class MovieWatchlistAddRemove extends MovieDetailWatchlistState {
  final String message;
  MovieWatchlistAddRemove({
    required this.message,
  });
}
