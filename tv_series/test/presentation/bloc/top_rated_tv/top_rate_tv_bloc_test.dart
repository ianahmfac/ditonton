import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rate_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTvBloc bloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = TopRatedTvBloc(mockGetTopRatedTvSeries);
  });

  test('Initial state should be [TopRateTvInitial]', () {
    expect(bloc.state, TopRateTvInitial());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [TopRateTvLoading, TopRatedTvLoaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvEvent()),
    expect: () => [
      TopRateTvLoading(),
      TopRatedTvLoaded(tvSeries: testTvList),
    ],
    verify: (bloc) => mockGetTopRatedTvSeries.execute(1),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [TopRatedTvLoadMore, TopRatedTvLoaded] when data is gotten from pagination successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvEvent(isLoadMore: true)),
    expect: () => [
      TopRatedTvLoadMore(),
      TopRatedTvLoaded(tvSeries: testTvList),
    ],
    verify: (bloc) => mockGetTopRatedTvSeries.execute(1),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [TopRateTvLoading, TopRatedTvError] when failed to fetch data',
    build: () {
      when(mockGetTopRatedTvSeries.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTvEvent()),
    expect: () => [
      TopRateTvLoading(),
      TopRatedTvError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetTopRatedTvSeries.execute(1),
  );
}
