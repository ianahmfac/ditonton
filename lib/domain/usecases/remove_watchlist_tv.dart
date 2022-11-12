import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
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
