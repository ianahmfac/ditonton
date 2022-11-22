import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_now_playing_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late HomeTvNowPlayingBloc bloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    bloc = HomeTvNowPlayingBloc(mockGetNowPlayingTvSeries);
  });

  test('Initial state should be [HomeTvNowPlayingInitial]', () {
    expect(bloc.state, HomeTvNowPlayingInitial());
  });

  blocTest<HomeTvNowPlayingBloc, HomeTvNowPlayingState>(
    'Should emit [HomeTvNowPlayingLoading, HomeTvNowPlayingLoaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeNowPlayingTv()),
    expect: () => [
      HomeTvNowPlayingLoading(),
      HomeTvNowPlayingLoaded(nowPlayingTv: testTvList),
    ],
    verify: (bloc) => mockGetNowPlayingTvSeries.execute(),
  );

  blocTest<HomeTvNowPlayingBloc, HomeTvNowPlayingState>(
    'Should emit [HomeTvNowPlayingLoading, HomeTvNowPlayingError] when failed to fetch data',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeNowPlayingTv()),
    expect: () => [
      HomeTvNowPlayingLoading(),
      HomeTvNowPlayingError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetNowPlayingTvSeries.execute(),
  );
}
