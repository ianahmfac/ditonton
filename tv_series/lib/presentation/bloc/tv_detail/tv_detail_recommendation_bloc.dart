import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_detail_recommendation.dart';

part 'tv_detail_recommendation_event.dart';
part 'tv_detail_recommendation_state.dart';

class TvDetailRecommendationBloc
    extends Bloc<TvDetailRecommendationEvent, TvDetailRecommendationState> {
  final GetTvDetailRecommendation getTvDetailRecommendation;
  TvDetailRecommendationBloc(this.getTvDetailRecommendation)
      : super(TvDetailRecommendationInitial()) {
    on<GetTvDetailRecommendationEvent>((event, emit) async {
      emit(TvDetailRecommendationLoading());
      final result = await getTvDetailRecommendation.execute(event.id);
      result.fold(
        (fail) => emit(TvDetailRecommendationError(fail.message)),
        (data) => emit(TvDetailRecommendationLoaded(data)),
      );
    });
  }
}
