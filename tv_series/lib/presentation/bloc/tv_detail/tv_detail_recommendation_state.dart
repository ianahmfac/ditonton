part of 'tv_detail_recommendation_bloc.dart';

abstract class TvDetailRecommendationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvDetailRecommendationInitial extends TvDetailRecommendationState {}

class TvDetailRecommendationLoading extends TvDetailRecommendationState {}

class TvDetailRecommendationLoaded extends TvDetailRecommendationState {
  final List<TvSeries> recommendations;

  TvDetailRecommendationLoaded(this.recommendations);

  @override
  List<Object?> get props => [recommendations];
}

class TvDetailRecommendationError extends TvDetailRecommendationState {
  final String message;

  TvDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
