import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
}
