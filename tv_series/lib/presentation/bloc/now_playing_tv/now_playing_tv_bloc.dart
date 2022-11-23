import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  NowPlayingTvBloc(
    this.getNowPlayingTvSeries,
  ) : super(NowPlayingTvInitial()) {
    on<GetNowPlayingTvEvent>((event, emit) async {
      emit(NowPlayingTvLoading());
      final result = await getNowPlayingTvSeries.execute();
      result.fold(
        (fail) => emit(NowPlayingTvError(message: fail.message)),
        (data) => emit(NowPlayingTvLoaded(tvSeries: data)),
      );
    });
  }
}
