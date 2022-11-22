import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

part 'home_tv_top_rated_event.dart';
part 'home_tv_top_rated_state.dart';

class HomeTvTopRatedBloc extends Bloc<HomeTvTopRatedEvent, HomeTvTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  HomeTvTopRatedBloc(
    this.getTopRatedTvSeries,
  ) : super(HomeTvTopRatedInitial()) {
    on<GetHomeTvTopRated>((event, emit) async {
      emit(HomeTvTopRatedLoading());
      final result = await getTopRatedTvSeries.execute(1);
      result.fold(
        (fail) => emit(HomeTvTopRatedError(message: fail.message)),
        (data) => emit(HomeTvTopRatedLoaded(topRatedTv: data)),
      );
    });
  }
}
