import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv_detail.dart';
import '../entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries(int page);
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries(int page);
  Future<Either<Failure, TvDetail>> getTvDetail(int tvId);
  Future<Either<Failure, List<TvSeries>>> getTvDetailRecommendation(int tvId);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tvSeries);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}
