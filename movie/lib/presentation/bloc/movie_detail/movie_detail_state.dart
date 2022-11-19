part of 'movie_detail_bloc.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  MovieDetailLoaded({
    required this.movieDetail,
  });
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError({
    required this.message,
  });
}
