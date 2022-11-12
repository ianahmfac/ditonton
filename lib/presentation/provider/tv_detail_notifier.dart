import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_detail_recommendation.dart';
import '../../domain/usecases/get_watchlist_tv_status.dart';
import '../../domain/usecases/remove_watchlist_tv.dart';
import '../../domain/usecases/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvDetailRecommendation getTvDetailRecommendation;
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchListTv removeWatchListTv;
  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvDetailRecommendation,
    required this.getWatchlistTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchListTv,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _detailState = RequestState.Empty;
  RequestState get detailState => _detailState;

  List<TvSeries> _recommendations = [];
  List<TvSeries> get recommendations => _recommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchDetail(int id) async {
    _detailState = RequestState.Loading;
    notifyListeners();

    final result = await getTvDetail.execute(id);
    result.fold(
      (failure) {
        _detailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvDetail) {
        _detailState = RequestState.Loaded;
        _tvDetail = tvDetail;
        notifyListeners();
      },
    );
  }

  Future<void> fetchRecommendations(int tvId) async {
    _recommendations.clear();
    _recommendationState = RequestState.Loading;
    notifyListeners();

    final result = await getTvDetailRecommendation.execute(tvId);
    result.fold(
      (failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (recommendations) {
        _recommendationState = RequestState.Loaded;
        _recommendations.addAll(recommendations);
        notifyListeners();
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistTvStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }

  Future<void> addWatchlist() async {
    final result = await saveWatchlistTv.execute(_tvDetail);
    result.fold(
      (failure) => _watchlistMessage = failure.message,
      (success) => _watchlistMessage = success,
    );
    loadWatchlistStatus(_tvDetail.id);
  }

  Future<void> removeWatchList() async {
    final result = await removeWatchListTv.execute(_tvDetail);
    result.fold(
      (failure) => _watchlistMessage = failure.message,
      (success) => _watchlistMessage = success,
    );
    loadWatchlistStatus(_tvDetail.id);
  }
}
