import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';

import '../../../../tv_series/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvDetail(tvSeriesRepository: mockTvSeriesRepository);
  });

  const tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvDetail(tId))
        .thenAnswer((_) async => const Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testTvDetail));
  });
}
