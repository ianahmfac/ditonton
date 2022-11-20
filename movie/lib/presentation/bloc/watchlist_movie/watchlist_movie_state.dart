part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> watchlistMovies;
  WatchlistMovieLoaded({
    required this.watchlistMovies,
  });

  @override
  List<Object?> get props => [watchlistMovies];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;
  WatchlistMovieError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
