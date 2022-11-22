import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/bloc/popular_tv_notifier.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    notifier = PopularTvNotifier(getPopularTvSeries: mockGetPopularTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  const tTv = TvSeries(
    backdropPath: 'backdropPath',
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'title',
  );
  final tTvList = <TvSeries>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvSeries.execute(1)).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvSeries.execute(1)).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvSeries, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvSeries.execute(1))
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvSeries();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
