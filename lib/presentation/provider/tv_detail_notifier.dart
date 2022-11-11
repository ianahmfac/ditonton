import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_detail_recommendation.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  final GetTvDetailRecommendation getTvDetailRecommendation;
  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvDetailRecommendation,
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
}
