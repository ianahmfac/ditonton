part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRecommendationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailRecommendationInitial extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoading extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoaded extends MovieDetailRecommendationState {
  final List<Movie> recommendations;

  MovieDetailRecommendationLoaded(this.recommendations);

  @override
  List<Object?> get props => [recommendations];
}

class MovieDetailRecommendationError extends MovieDetailRecommendationState {
  final String message;

  MovieDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
