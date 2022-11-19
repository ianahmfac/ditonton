import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_notifier.dart';

import 'now_playing_tv_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = NowPlayingTvNotifier(getNowPlayingTvSeries: mockGetNowPlayingTvSeries)
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
    when(mockGetNowPlayingTvSeries.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchNowPlaying();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTvSeries.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchNowPlaying();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvSeries, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlaying();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
