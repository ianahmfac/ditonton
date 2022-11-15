import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvSeriesRepository,
])
void main() {}
