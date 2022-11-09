import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_now_playing_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  TvSeriesListNotifier({
    required this.getNowPlayingTvSeries,
  });

  List<TvSeries> _nowPlayings = [];
  List<TvSeries> get nowPlayings => _nowPlayings;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayings.addAll(tvSeries);
        notifyListeners();
      },
    );
  }
}
