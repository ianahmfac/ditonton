import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/search_tv_series.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSearchNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _searchResult.clear();
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult.addAll(data);
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
