import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_top_rated_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late HomeTvTopRatedBloc bloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = HomeTvTopRatedBloc(mockGetTopRatedTvSeries);
  });

  test('Initial state should be [HomeTvTopRatedInitial]', () {
    expect(bloc.state, HomeTvTopRatedInitial());
  });

  blocTest<HomeTvTopRatedBloc, HomeTvTopRatedState>(
    'Should emit [HomeTvTopRatedLoading, HomeTvTopRatedLoaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeTvTopRated()),
    expect: () => [
      HomeTvTopRatedLoading(),
      HomeTvTopRatedLoaded(topRatedTv: testTvList),
    ],
    verify: (bloc) => mockGetTopRatedTvSeries.execute(1),
  );

  blocTest<HomeTvTopRatedBloc, HomeTvTopRatedState>(
    'Should emit [HomeTvTopRatedLoading, HomeTvTopRatedError] when failed to fetch data',
    build: () {
      when(mockGetTopRatedTvSeries.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeTvTopRated()),
    expect: () => [
      HomeTvTopRatedLoading(),
      HomeTvTopRatedError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetTopRatedTvSeries.execute(1),
  );
}
