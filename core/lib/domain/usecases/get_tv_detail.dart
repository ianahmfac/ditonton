import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class GetTvDetail {
  final TvSeriesRepository tvSeriesRepository;
  GetTvDetail({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, TvDetail>> execute(int tvId) {
    return tvSeriesRepository.getTvDetail(tvId);
  }
}
