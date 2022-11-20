import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

import '../../../domain/entities/movie.dart';

part 'movie_detail_recommendation_event.dart';
part 'movie_detail_recommendation_state.dart';

class MovieDetailRecommendationBloc
    extends Bloc<MovieDetailRecommendationEvent, MovieDetailRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  MovieDetailRecommendationBloc(
    this.getMovieRecommendations,
  ) : super(MovieDetailRecommendationInitial()) {
    on<GetMovieRecommendationsEvent>((event, emit) async {
      emit(MovieDetailRecommendationLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold(
        (fail) => emit(MovieDetailRecommendationError(fail.message)),
        (data) => emit(MovieDetailRecommendationLoaded(data)),
      );
    });
  }
}
