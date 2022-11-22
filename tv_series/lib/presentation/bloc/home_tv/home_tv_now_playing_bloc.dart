import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';

part 'home_tv_now_playing_event.dart';
part 'home_tv_now_playing_state.dart';

class HomeTvNowPlayingBloc extends Bloc<HomeTvNowPlayingEvent, HomeTvNowPlayingState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  HomeTvNowPlayingBloc(
    this.getNowPlayingTvSeries,
  ) : super(HomeTvNowPlayingInitial()) {
    on<GetHomeNowPlayingTv>((event, emit) async {
      emit(HomeTvNowPlayingLoading());
      final result = await getNowPlayingTvSeries.execute();

      result.fold(
        (fail) => emit(HomeTvNowPlayingError(message: fail.message)),
        (data) => emit(HomeTvNowPlayingLoaded(nowPlayingTv: data)),
      );
    });
  }
}
