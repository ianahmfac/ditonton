part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRecommendationState {}

class MovieDetailRecommendationInitial extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoading extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoaded extends MovieDetailRecommendationState {
  final List<Movie> recommendations;
  MovieDetailRecommendationLoaded({
    required this.recommendations,
  });
}

class MovieDetailRecommendationError extends MovieDetailRecommendationState {
  final String message;
  MovieDetailRecommendationError({
    required this.message,
  });
}
