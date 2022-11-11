import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTvDetailRecommendation {
  final TvSeriesRepository tvSeriesRepository;
  GetTvDetailRecommendation({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, List<TvSeries>>> execute(int tvId) {
    return tvSeriesRepository.getTvDetailRecommendation(tvId);
  }
}
