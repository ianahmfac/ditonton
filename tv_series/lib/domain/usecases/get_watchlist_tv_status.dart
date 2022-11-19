import '../repositories/tv_series_repository.dart';

class GetWatchlistTvStatus {
  final TvSeriesRepository tvSeriesRepository;
  GetWatchlistTvStatus({
    required this.tvSeriesRepository,
  });

  Future<bool> execute(int id) {
    return tvSeriesRepository.isAddedToWatchlistTv(id);
  }
}
