import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvBloc(
    this.getPopularTvSeries,
  ) : super(PopularTvInitial()) {
    int page = 1;
    List<TvSeries> tvSeries = [];

    on<GetPopularTvEvent>((event, emit) async {
      if (!event.isLoadMore) {
        tvSeries.clear();
        page = 1;
        emit(PopularTvLoading());
      } else {
        emit(PopularTvLoadMore());
      }

      final result = await getPopularTvSeries.execute(page);

      result.fold(
        (fail) {
          if (event.isLoadMore) return;
          emit(PopularTvError(message: fail.message));
        },
        (data) {
          tvSeries.addAll(data);
          emit(PopularTvLoaded(tvSeries: tvSeries));
          if (data.isNotEmpty) {
            page++;
          }
        },
      );
    });
  }
}
