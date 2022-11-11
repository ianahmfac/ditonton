import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_detail.dart';
import '../entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries(int page);
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries(int page);
  Future<Either<Failure, TvDetail>> getTvDetail(int tvId);
}
