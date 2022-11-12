import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(repository: mockTvSeriesRepository);
  });

  final tTv = <TvSeries>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTopRatedTvSeries(1)).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tTv));
  });
}
