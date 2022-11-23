import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

import '../../../domain/entities/tv_series.dart';

part 'top_rate_tv_event.dart';
part 'top_rate_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  TopRatedTvBloc(
    this.getTopRatedTvSeries,
  ) : super(TopRateTvInitial()) {
    int page = 1;
    List<TvSeries> tvSeries = [];

    on<GetTopRatedTvEvent>((event, emit) async {
      if (!event.isLoadMore) {
        tvSeries.clear();
        page = 1;
        emit(TopRateTvLoading());
      } else {
        emit(TopRatedTvLoadMore());
      }

      final result = await getTopRatedTvSeries.execute(page);

      result.fold(
        (fail) {
          if (event.isLoadMore) return;
          emit(TopRatedTvError(message: fail.message));
        },
        (data) {
          tvSeries.addAll(data);
          emit(TopRatedTvLoaded(tvSeries: tvSeries));
          if (data.isNotEmpty) {
            page++;
          }
        },
      );
    });
  }
}
