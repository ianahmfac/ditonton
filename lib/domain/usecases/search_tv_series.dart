import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository tvSeriesRepository;
  SearchTvSeries({
    required this.tvSeriesRepository,
  });

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return tvSeriesRepository.searchTvSeries(query);
  }
}
