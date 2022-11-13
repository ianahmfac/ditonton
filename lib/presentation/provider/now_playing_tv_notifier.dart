import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_now_playing_tv_series.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  NowPlayingTvNotifier({
    required this.getNowPlayingTvSeries,
  });

  final List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlaying() async {
    _tvSeries.clear();
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _state = RequestState.Loaded;
        _tvSeries.addAll(tv);
        notifyListeners();
      },
    );
  }
}
