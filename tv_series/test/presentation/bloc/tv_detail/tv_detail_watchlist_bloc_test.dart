import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc_export.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvDetailWatchlistBloc bloc;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchListTv mockRemoteWatchlistTv;

  setUp(() {
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoteWatchlistTv = MockRemoveWatchListTv();
    bloc = TvDetailWatchlistBloc(
      mockGetWatchlistTvStatus,
      mockSaveWatchlistTv,
      mockRemoteWatchlistTv,
    );
  });

  test(
    'Intial state should be [TvDetailWatchlistInitial]',
    () {
      expect(bloc.state, TvDetailWatchlistInitial());
    },
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'emits [TvWatchlistStatus] with true when GetWatchListTvStatusEvent is added.',
    build: () {
      when(mockGetWatchlistTvStatus.execute(1)).thenAnswer((realInvocation) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchListTvStatusEvent(id: 1)),
    expect: () => [
      TvWatchlistStatus(true),
    ],
    verify: (bloc) => mockGetWatchlistTvStatus.execute(1),
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'emits [TvWatchlistStatus] with false when GetWatchListTvStatusEvent is added.',
    build: () {
      when(mockGetWatchlistTvStatus.execute(1)).thenAnswer((realInvocation) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchListTvStatusEvent(id: 1)),
    expect: () => [
      TvWatchlistStatus(false),
    ],
    verify: (bloc) => mockGetWatchlistTvStatus.execute(1),
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'should update watchlist status when add watchlist success',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((realInvocation) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistTvEvent(tvDetail: testTvDetail)),
    expect: () => [
      TvWatchlistAddRemove('Added to Watchlist'),
      TvWatchlistStatus(true),
    ],
    verify: (bloc) => mockSaveWatchlistTv.execute(testTvDetail),
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'should update watchlist status when add watchlist failed',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistTvEvent(tvDetail: testTvDetail)),
    expect: () => [
      TvWatchlistAddRemove('Failed'),
      TvWatchlistStatus(false),
    ],
    verify: (bloc) => mockSaveWatchlistTv.execute(testTvDetail),
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'should update watchlist status when remove watchlist success',
    build: () {
      when(mockRemoteWatchlistTv.execute(testTvDetail))
          .thenAnswer((realInvocation) async => const Right('Removed from Watchlist'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistTvEvent(tvDetail: testTvDetail)),
    expect: () => [
      TvWatchlistAddRemove('Removed from Watchlist'),
      TvWatchlistStatus(false),
    ],
    verify: (bloc) => mockRemoteWatchlistTv.execute(testTvDetail),
  );

  blocTest<TvDetailWatchlistBloc, TvDetailWatchlistState>(
    'should update watchlist status when add watchlist failed',
    build: () {
      when(mockRemoteWatchlistTv.execute(testTvDetail))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistTvEvent(tvDetail: testTvDetail)),
    expect: () => [
      TvWatchlistAddRemove('Failed'),
      TvWatchlistStatus(true),
    ],
    verify: (bloc) => mockRemoteWatchlistTv.execute(testTvDetail),
  );
}
