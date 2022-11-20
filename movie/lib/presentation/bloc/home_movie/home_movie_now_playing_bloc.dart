import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'home_movie_now_playing_event.dart';
part 'home_movie_now_playing_state.dart';

class HomeMovieNowPlayingBloc extends Bloc<HomeMovieNowPlayingEvent, HomeMovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  HomeMovieNowPlayingBloc(
    this.getNowPlayingMovies,
  ) : super(HomeMovieNowPlayingInitial()) {
    on<GetHomeNowPlayingMovies>((event, emit) async {
      emit(HomeMovieNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (fail) => emit(HomeMovieNowPlayingError(message: fail.message)),
        (data) => emit(HomeMovieNowPlayingLoaded(nowPlayingMovies: data)),
      );
    });
  }
}
