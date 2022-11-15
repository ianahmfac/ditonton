import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_detail_recommendation.dart';
import 'package:core/domain/usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:core/presentation/provider/tv_detail_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvDetailRecommendation,
  GetWatchlistTvStatus,
  SaveWatchlistTv,
  RemoveWatchListTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvDetailRecommendation mockGetTvRecommendation;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchListTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendation = MockGetTvDetailRecommendation();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchListTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvDetailRecommendation: mockGetTvRecommendation,
      getWatchlistTvStatus: mockGetWatchlistTvStatus,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchListTv: mockRemoveWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

  const tTv = TvSeries(
    backdropPath: 'backdropPath',
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'title',
  );
  final tTvList = <TvSeries>[tTv];

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
      // act
      await provider.fetchDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
      // act
      provider.fetchDetail(tId);
      // assert
      expect(provider.detailState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => const Right(testTvDetail));
      // act
      await provider.fetchDetail(tId);
      // assert
      expect(provider.detailState, RequestState.loaded);
      expect(provider.tvDetail, testTvDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvRecommendation.execute(tId)).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchRecommendations(tId);
      // assert
      verify(mockGetTvRecommendation.execute(tId));
      expect(provider.recommendations, tTvList);
    });

    test('should update recommendation state when data is gotten successfully', () async {
      // arrange
      when(mockGetTvRecommendation.execute(tId)).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchRecommendations(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.recommendations, tTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchRecommendations(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTvStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id)).thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id)).thenAnswer((_) async => false);
      // act
      await provider.removeWatchList(testTvDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id)).thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchlistTvStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvStatus.execute(testTvDetail.id)).thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendation.execute(tId)).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchDetail(tId);
      // assert
      expect(provider.detailState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
