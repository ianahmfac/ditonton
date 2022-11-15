import 'package:core/core.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/presentation/provider/watchlist_tv_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchListTv])
void main() {
  late WatchListTvNotifier provider;
  late MockGetWatchListTv mockGetWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchListTv();
    provider = WatchListTvNotifier(
      getWatchListTv: mockGetWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTv.execute()).thenAnswer((_) async => const Right([testWatchlistTv]));
    // act
    await provider.fetchWatchList();
    // assert
    expect(provider.state, RequestState.loaded);
    expect(provider.watchlists, [testWatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTv.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchList();
    // assert
    expect(provider.state, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
