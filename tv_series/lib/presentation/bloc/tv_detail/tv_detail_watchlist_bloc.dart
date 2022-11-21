import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';

part 'tv_detail_watchlist_event.dart';
part 'tv_detail_watchlist_state.dart';

class TvDetailWatchlistBloc extends Bloc<TvDetailWatchlistEvent, TvDetailWatchlistState> {
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchListTv removeWatchListTv;
  TvDetailWatchlistBloc(
    this.getWatchlistTvStatus,
    this.saveWatchlistTv,
    this.removeWatchListTv,
  ) : super(TvDetailWatchlistInitial()) {
    on<GetWatchListTvStatusEvent>((event, emit) async {
      final result = await getWatchlistTvStatus.execute(event.id);
      emit(TvWatchlistStatus(result));
    });
    on<SaveWatchlistTvEvent>((event, emit) async {
      final result = await saveWatchlistTv.execute(event.tvDetail);
      result.fold(
        (fail) => emit(TvWatchlistAddRemove(fail.message)),
        (message) => emit(TvWatchlistAddRemove(message)),
      );
      add(GetWatchListTvStatusEvent(id: event.tvDetail.id));
    });
    on<RemoveWatchlistTvEvent>((event, emit) async {
      final result = await removeWatchListTv.execute(event.tvDetail);
      result.fold(
        (fail) => emit(TvWatchlistAddRemove(fail.message)),
        (message) => emit(TvWatchlistAddRemove(message)),
      );
      add(GetWatchListTvStatusEvent(id: event.tvDetail.id));
    });
  }
}
