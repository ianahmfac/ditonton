part of 'tv_detail_watchlist_bloc.dart';

abstract class TvDetailWatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWatchListTvStatusEvent extends TvDetailWatchlistEvent {
  final int id;
  GetWatchListTvStatusEvent({
    required this.id,
  });
}

class SaveWatchlistTvEvent extends TvDetailWatchlistEvent {
  final TvDetail tvDetail;
  SaveWatchlistTvEvent({
    required this.tvDetail,
  });
}

class RemoveWatchlistTvEvent extends TvDetailWatchlistEvent {
  final TvDetail tvDetail;
  RemoveWatchlistTvEvent({
    required this.tvDetail,
  });
}
