import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository,
])
void main() {}
