import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

part 'home_tv_popular_event.dart';
part 'home_tv_popular_state.dart';

class HomeTvPopularBloc extends Bloc<HomeTvPopularEvent, HomeTvPopularState> {
  final GetPopularTvSeries getPopularTvSeries;
  HomeTvPopularBloc(
    this.getPopularTvSeries,
  ) : super(HomeTvPopularInitial()) {
    on<GetHomeTvPopular>((event, emit) async {
      emit(HomeTvPopularLoading());
      final result = await getPopularTvSeries.execute(1);

      result.fold(
        (fail) => emit(HomeTvPopularError(message: fail.message)),
        (data) => emit(HomeTvPopularLoaded(popularTv: data)),
      );
    });
  }
}
