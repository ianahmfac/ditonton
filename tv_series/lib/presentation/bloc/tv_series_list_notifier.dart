import 'package:core/core.dart';
import 'package:flutter/material.dart';

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

  final List<TvSeries> _nowPlayings = [];
  List<TvSeries> get nowPlayings => _nowPlayings;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  final List<TvSeries> _populars = [];
  List<TvSeries> get populars => _populars;

  RequestState _popularState = RequestState.empty;
  RequestState get popularState => _popularState;

  final List<TvSeries> _topRates = [];
  List<TvSeries> get topRates => _topRates;

  RequestState _topRatedState = RequestState.empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayings.addAll(tvSeries);
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute(1);
    result.fold(
      (failure) {
        _popularState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _popularState = RequestState.loaded;
        _populars.addAll(tvSeries);
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute(1);
    result.fold(
      (failure) {
        _topRatedState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _topRatedState = RequestState.loaded;
        _topRates.addAll(tvSeries);
        notifyListeners();
      },
    );
  }
}
