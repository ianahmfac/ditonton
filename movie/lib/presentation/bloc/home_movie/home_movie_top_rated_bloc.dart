import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'home_movie_top_rated_event.dart';
part 'home_movie_top_rated_state.dart';

class HomeMovieTopRatedBloc extends Bloc<HomeMovieTopRatedEvent, HomeMovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  HomeMovieTopRatedBloc(
    this.getTopRatedMovies,
  ) : super(HomeMovieTopRatedInitial()) {
    on<GetHomeMovieTopRated>((event, emit) async {
      emit(HomeMovieTopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (fail) => emit(HomeMovieTopRatedError(message: fail.message)),
        (data) => emit(HomeMovieTopRatedLoaded(topRatedMovies: data)),
      );
    });
  }
}
