part of 'tv_detail_recommendation_bloc.dart';

abstract class TvDetailRecommendationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTvDetailRecommendationEvent extends TvDetailRecommendationEvent {
  final int id;
  GetTvDetailRecommendationEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [];
}
