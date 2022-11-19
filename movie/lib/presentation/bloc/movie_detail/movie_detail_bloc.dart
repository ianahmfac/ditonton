import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(event.id);
      result.fold(
        (fail) => emit(MovieDetailError(message: fail.message)),
        (data) => emit(MovieDetailLoaded(movieDetail: data)),
      );
    });
  }
}
