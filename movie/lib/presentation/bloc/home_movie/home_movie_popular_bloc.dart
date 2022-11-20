import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'home_movie_popular_event.dart';
part 'home_movie_popular_state.dart';

class HomeMoviePopularBloc extends Bloc<HomeMoviePopularEvent, HomeMoviePopularState> {
  final GetPopularMovies getPopularMovies;
  HomeMoviePopularBloc(
    this.getPopularMovies,
  ) : super(HomeMoviePopularInitial()) {
    on<GetHomeMoviePopular>((event, emit) async {
      emit(HomeMoviePopularLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (fail) => emit(HomeMoviePopularError(message: fail.message)),
        (data) => emit(HomeMoviePopularLoaded(popularMovies: data)),
      );
    });
  }
}
