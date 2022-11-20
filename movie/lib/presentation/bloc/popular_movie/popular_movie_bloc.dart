import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc(
    this.getPopularMovies,
  ) : super(PopularMovieInitial()) {
    on<GetPopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (fail) => emit(PopularMovieError(message: fail.message)),
        (data) => emit(PopularMovieLoaded(popularMovies: data)),
      );
    });
  }
}
