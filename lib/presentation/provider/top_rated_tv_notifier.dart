import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
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

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries({bool init = true}) async {
    if (init) {
      _page = 1;
      _state = RequestState.Loading;
      _tvSeries.clear();
      notifyListeners();
    }
    final result = await getTopRatedTvSeries.execute(_page);
    result.fold(
      (failure) {
        if (init) {
          _state = RequestState.Error;
          _message = failure.message;
          notifyListeners();
        }
      },
      (tv) {
        _state = RequestState.Loaded;
        _tvSeries.addAll(tv);
        if (tv.isNotEmpty) {
          _page++;
        }
        notifyListeners();
      },
    );
  }
}
