import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingTvBloc bloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    bloc = NowPlayingTvBloc(mockGetNowPlayingTvSeries);
  });

  test('Initial state should be [NowPlayingTvInitial]', () {
    expect(bloc.state, NowPlayingTvInitial());
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [NowPlayingTvLoading, NowPlayingTvLoaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvLoaded(tvSeries: testTvList),
    ],
    verify: (bloc) => mockGetNowPlayingTvSeries.execute(),
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'Should emit [NowPlayingTvLoading, NowPlayingTvError] when failed to fetch data',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetNowPlayingTvSeries.execute(),
  );
}
