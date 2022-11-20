part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTopRatedMoviesEvent extends TopRatedMovieEvent {}
