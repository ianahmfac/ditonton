import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc(
    this.getWatchlistMovies,
  ) : super(WatchlistMovieInitial()) {
    on<GetWatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (fail) => emit(WatchlistMovieError(message: fail.message)),
        (data) => emit(WatchlistMovieLoaded(watchlistMovies: data)),
      );
    });
  }
}
