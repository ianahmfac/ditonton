part of 'popular_movie_bloc.dart';

abstract class PopularMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPopularMovieEvent extends PopularMovieEvent {}
