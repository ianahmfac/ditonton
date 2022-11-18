import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  SearchBloc(
    this.searchMovies,
  ) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await searchMovies.execute(query);

        result.fold(
          (fail) => emit(SearchError(fail.message)),
          (data) => emit(SearchHasData(data)),
        );
      },
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(seconds: 1)).flatMap(mapper),
    );
  }
}
