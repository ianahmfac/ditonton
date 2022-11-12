import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_watchlist_tv.dart';

class WatchListTvNotifier extends ChangeNotifier {
  final GetWatchListTv getWatchListTv;
  WatchListTvNotifier({
    required this.getWatchListTv,
  });

  final List<TvSeries> _watchlists = [];
  List<TvSeries> get watchlists => _watchlists;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchList() async {
    _watchlists.clear();
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTv.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _state = RequestState.Loaded;
        _watchlists.addAll(tv);
        notifyListeners();
      },
    );
  }
}
