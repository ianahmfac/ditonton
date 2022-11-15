import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_now_playing_tv_series.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  NowPlayingTvNotifier({
    required this.getNowPlayingTvSeries,
  });

  final List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlaying() async {
    _tvSeries.clear();
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _state = RequestState.loaded;
        _tvSeries.addAll(tv);
        notifyListeners();
      },
    );
  }
}
