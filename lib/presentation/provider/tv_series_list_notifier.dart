import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_now_playing_tv_series.dart';
import '../../domain/usecases/get_popular_tv_series.dart';
import '../../domain/usecases/get_top_rated_tv_series.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;
  TvSeriesListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  List<TvSeries> _nowPlayings = [];
  List<TvSeries> get nowPlayings => _nowPlayings;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  List<TvSeries> _populars = [];
  List<TvSeries> get populars => _populars;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  List<TvSeries> _topRates = [];
  List<TvSeries> get topRates => _topRates;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

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

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute(1);
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _popularState = RequestState.Loaded;
        _populars.addAll(tvSeries);
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute(1);
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _topRatedState = RequestState.Loaded;
        _topRates.addAll(tvSeries);
        notifyListeners();
      },
    );
  }
}
