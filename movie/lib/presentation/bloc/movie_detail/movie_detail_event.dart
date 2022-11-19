part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;
  GetMovieDetailEvent({
    required this.id,
  });
}
