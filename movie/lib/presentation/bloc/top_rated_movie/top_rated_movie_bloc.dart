import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieBloc(
    this.getTopRatedMovies,
  ) : super(TopRatedMovieInitial()) {
    on<GetTopRatedMoviesEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (fail) => emit(TopRatedMovieError(message: fail.message)),
        (data) => emit(TopRatedMovieLoaded(topRatedMovies: data)),
      );
    });
  }
}
