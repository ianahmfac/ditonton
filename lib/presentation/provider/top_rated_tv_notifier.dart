import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_top_rated_tv_series.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;
  TopRatedTvNotifier({
    required this.getTopRatedTvSeries,
  });

  final List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  int _page = 1;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries({bool init = true}) async {
    if (init) {
      _page = 1;
      _state = RequestState.loading;
      _tvSeries.clear();
      notifyListeners();
    }
    final result = await getTopRatedTvSeries.execute(_page);
    result.fold(
      (failure) {
        if (init) {
          _state = RequestState.error;
          _message = failure.message;
          notifyListeners();
        }
      },
      (tv) {
        _state = RequestState.loaded;
        _tvSeries.addAll(tv);
        if (tv.isNotEmpty) {
          _page++;
        }
        notifyListeners();
      },
    );
  }
}
