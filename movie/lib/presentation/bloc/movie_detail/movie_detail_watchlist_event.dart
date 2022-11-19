part of 'movie_detail_watchlist_bloc.dart';

abstract class MovieDetailWatchlistEvent {}

class GetWatchListStatusEvent extends MovieDetailWatchlistEvent {
  final int id;
  GetWatchListStatusEvent({
    required this.id,
  });
}

class SaveWatchlistEvent extends MovieDetailWatchlistEvent {
  final MovieDetail movie;
  SaveWatchlistEvent({
    required this.movie,
  });
}

class RemoveWatchlistEvent extends MovieDetailWatchlistEvent {
  final MovieDetail movie;
  RemoveWatchlistEvent({
    required this.movie,
  });
}
