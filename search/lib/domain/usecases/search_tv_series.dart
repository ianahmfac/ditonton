import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class SearchTvSeries {
  final TvSeriesRepository tvSeriesRepository;
  SearchTvSeries({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return tvSeriesRepository.searchTvSeries(query);
  }
}
