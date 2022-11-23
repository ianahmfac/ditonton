import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_popular_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late HomeTvPopularBloc bloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    bloc = HomeTvPopularBloc(mockGetPopularTvSeries);
  });

  test('Initial state should be [HomeTvPopularInitial]', () {
    expect(bloc.state, HomeTvPopularInitial());
  });

  blocTest<HomeTvPopularBloc, HomeTvPopularState>(
    'Should emit [HomeTvPopularLoading, HomeTvPopularLoaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeTvPopular()),
    expect: () => [
      HomeTvPopularLoading(),
      HomeTvPopularLoaded(popularTv: testTvList),
    ],
    verify: (bloc) => mockGetPopularTvSeries.execute(1),
  );

  blocTest<HomeTvPopularBloc, HomeTvPopularState>(
    'Should emit [HomeTvPopularLoading, HomeTvPopularError] when failed to fetch data',
    build: () {
      when(mockGetPopularTvSeries.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeTvPopular()),
    expect: () => [
      HomeTvPopularLoading(),
      HomeTvPopularError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetPopularTvSeries.execute(1),
  );
}
