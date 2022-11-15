import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_detail_recommendation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetailRecommendation usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvDetailRecommendation(tvSeriesRepository: mockTvSeriesRepository);
  });

  const tId = 1;
  final tTv = <TvSeries>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvDetailRecommendation(tId)).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}
