part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRecommendationEvent {}

class GetMovieRecommendationsEvent extends MovieDetailRecommendationEvent {
  final int id;
  GetMovieRecommendationsEvent({
    required this.id,
  });
}
