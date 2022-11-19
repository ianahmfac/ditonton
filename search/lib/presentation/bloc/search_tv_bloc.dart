import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  SearchTvSeries searchTvSeries;
  SearchTvBloc(
    this.searchTvSeries,
  ) : super(SearchTvEmpty()) {
    on<OnTvQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(SearchTvLoading());

        final result = await searchTvSeries.execute(query);

        result.fold(
          (fail) => emit(SearchTvError(fail.message)),
          (data) => emit(SearchTvHasData(data)),
        );
      },
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(seconds: 1)).flatMap(mapper),
    );
  }
}
