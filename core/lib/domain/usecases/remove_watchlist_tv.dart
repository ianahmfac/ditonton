import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class RemoveWatchListTv {
  final TvSeriesRepository tvSeriesRepository;
  RemoveWatchListTv({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, String>> execute(TvDetail tvSeries) {
    return tvSeriesRepository.removeWatchlistTv(tvSeries);
  }
}
