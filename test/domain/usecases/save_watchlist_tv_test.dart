import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTv(tvSeriesRepository: mockTvSeriesRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvSeriesRepository.saveWatchlistTv(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
