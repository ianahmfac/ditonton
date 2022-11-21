import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc_export.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvDetailRecommendationBloc bloc;
  late MockGetTvDetailRecommendation mockGetTvDetailRecommendation;

  setUp(() {
    mockGetTvDetailRecommendation = MockGetTvDetailRecommendation();
    bloc = TvDetailRecommendationBloc(mockGetTvDetailRecommendation);
  });

  test('Initial state should be [TvDetailRecommendationInitial]', () {
    expect(bloc.state, TvDetailRecommendationInitial());
  });

  blocTest<TvDetailRecommendationBloc, TvDetailRecommendationState>(
    'Should emit [TvDetailRecommendationLoading, TvDetailRecommendationLoaded] when data is gotten successfully',
    build: () {
      when(mockGetTvDetailRecommendation.execute(1))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTvDetailRecommendationEvent(id: 1)),
    expect: () => [
      TvDetailRecommendationLoading(),
      TvDetailRecommendationLoaded(testTvList),
    ],
    verify: (bloc) => mockGetTvDetailRecommendation.execute(1),
  );

  blocTest<TvDetailRecommendationBloc, TvDetailRecommendationState>(
    'Should emit [TvDetailRecommendationLoading, TvDetailRecommendationError] when failed to fetch data',
    build: () {
      when(mockGetTvDetailRecommendation.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTvDetailRecommendationEvent(id: 1)),
    expect: () => [
      TvDetailRecommendationLoading(),
      TvDetailRecommendationError('Failed'),
    ],
    verify: (bloc) => mockGetTvDetailRecommendation.execute(1),
  );
}
