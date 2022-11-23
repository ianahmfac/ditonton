import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistTvBloc bloc;
  late MockGetWatchListTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchListTv();
    bloc = WatchlistTvBloc(mockGetWatchlistTv);
  });

  test('Initial state should be [WatchlistTvInitial]', () {
    expect(bloc.state, WatchlistTvInitial());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [WatchlistTvLoading, WatchlistTvLoaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvEvent()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvLoaded(tvSeries: testTvList),
    ],
    verify: (bloc) => mockGetWatchlistTv.execute(),
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [WatchlistTvLoading, WatchlistTvError] when failed to fetch data',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvEvent()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetWatchlistTv.execute(),
  );
}
