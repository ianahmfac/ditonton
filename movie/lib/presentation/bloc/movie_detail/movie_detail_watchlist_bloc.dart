import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

import '../../../domain/entities/movie_detail.dart';

part 'movie_detail_watchlist_event.dart';
part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistBloc extends Bloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  MovieDetailWatchlistBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieDetailWatchlistInitial()) {
    on<GetWatchListStatusEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(MovieWatchlistStatus(result));
    });
    on<SaveWatchlistEvent>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);
      result.fold(
        (fail) => emit(MovieWatchlistAddRemove(fail.message)),
        (message) => emit(MovieWatchlistAddRemove(message)),
      );
      add(GetWatchListStatusEvent(id: event.movie.id));
    });
    on<RemoveWatchlistEvent>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);
      result.fold(
        (fail) => emit(MovieWatchlistAddRemove(fail.message)),
        (message) => emit(MovieWatchlistAddRemove(message)),
      );
      add(GetWatchListStatusEvent(id: event.movie.id));
    });
  }
}
