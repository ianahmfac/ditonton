import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc_export.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvDetailBloc bloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    bloc = TvDetailBloc(mockGetTvDetail);
  });

  test('Initial state should be [TvDetailInitial]', () {
    expect(bloc.state, TvDetailInitial());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [TvDetailLoading, TvDetailLoaded] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((realInvocation) async => const Right(testTvDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTvDetailEvent(id: 1)),
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(testTvDetail),
    ],
    verify: (bloc) => mockGetTvDetail.execute(1),
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [TvDetailLoading, TvDetailError] when failed to fetch data',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTvDetailEvent(id: 1)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Failed'),
    ],
    verify: (bloc) => mockGetTvDetail.execute(1),
  );
}
