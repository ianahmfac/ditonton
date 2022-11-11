import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_detail.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetTvDetail getTvDetail;
  TvDetailNotifier({
    required this.getTvDetail,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _detailState = RequestState.Empty;
  RequestState get detailState => _detailState;

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
}
