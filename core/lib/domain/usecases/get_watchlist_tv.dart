import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetWatchListTv {
  final TvSeriesRepository tvSeriesRepository;
  GetWatchListTv({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, List<TvSeries>>> execute() {
    return tvSeriesRepository.getWatchlistTv();
  }
}
