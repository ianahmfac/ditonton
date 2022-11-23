import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTvBloc bloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    bloc = PopularTvBloc(mockGetPopularTvSeries);
  });

  test('Initial state should be [PopularTvInitial]', () {
    expect(bloc.state, PopularTvInitial());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [PopularTvLoading, PopularTvLoaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularTvEvent()),
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(tvSeries: testTvList),
    ],
    verify: (bloc) => mockGetPopularTvSeries.execute(1),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [PopularTvLoadMore, PopularTvLoaded] when data is gotten from pagination successfully',
    build: () {
      when(mockGetPopularTvSeries.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularTvEvent(isLoadMore: true)),
    expect: () => [
      PopularTvLoadMore(),
      PopularTvLoaded(tvSeries: testTvList),
    ],
    verify: (bloc) => mockGetPopularTvSeries.execute(1),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [PopularTvLoading, PopularTvError] when failed to fetch data',
    build: () {
      when(mockGetPopularTvSeries.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularTvEvent()),
    expect: () => [
      PopularTvLoading(),
      PopularTvError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetPopularTvSeries.execute(1),
  );
}
