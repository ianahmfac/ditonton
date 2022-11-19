import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class SaveWatchlistTv {
  final TvSeriesRepository tvSeriesRepository;
  SaveWatchlistTv({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, String>> execute(TvDetail tvSeries) {
    return tvSeriesRepository.saveWatchlistTv(tvSeries);
  }
}
