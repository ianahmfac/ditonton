import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository tvSeriesRepository;
  SearchTvSeries({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return tvSeriesRepository.searchTvSeries(query);
  }
}
