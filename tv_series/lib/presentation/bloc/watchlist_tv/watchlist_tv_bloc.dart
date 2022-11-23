import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListTv getWatchListTv;
  WatchlistTvBloc(
    this.getWatchListTv,
  ) : super(WatchlistTvInitial()) {
    on<GetWatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchListTv.execute();
      result.fold(
        (fail) => emit(WatchlistTvError(message: fail.message)),
        (data) => emit(WatchlistTvLoaded(tvSeries: data)),
      );
    });
  }
}
