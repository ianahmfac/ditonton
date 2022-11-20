import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MovieDetailWatchlistBloc bloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailWatchlistBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test(
    'Intial state should be [MovieDetailWatchListInitial]',
    () {
      expect(bloc.state, MovieDetailWatchlistInitial());
    },
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'emits [MovieWatchlistStatus] with true when GetWatchListStatusEvent is added.',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((realInvocation) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchListStatusEvent(id: 1)),
    expect: () => [
      MovieWatchlistStatus(true),
    ],
    verify: (bloc) => mockGetWatchListStatus.execute(1),
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'emits [MovieWatchlistStatus] with false when GetWatchListStatusEvent is added.',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((realInvocation) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchListStatusEvent(id: 1)),
    expect: () => [
      MovieWatchlistStatus(false),
    ],
    verify: (bloc) => mockGetWatchListStatus.execute(1),
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'should update watchlist status when add watchlist success',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistEvent(movie: testMovieDetail)),
    expect: () => [
      MovieWatchlistAddRemove('Added to Watchlist'),
      MovieWatchlistStatus(true),
    ],
    verify: (bloc) => mockSaveWatchlist.execute(testMovieDetail),
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'should update watchlist status when add watchlist failed',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(SaveWatchlistEvent(movie: testMovieDetail)),
    expect: () => [
      MovieWatchlistAddRemove('Failed'),
      MovieWatchlistStatus(false),
    ],
    verify: (bloc) => mockSaveWatchlist.execute(testMovieDetail),
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'should update watchlist status when remove watchlist success',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => const Right('Removed from Watchlist'));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistEvent(movie: testMovieDetail)),
    expect: () => [
      MovieWatchlistAddRemove('Removed from Watchlist'),
      MovieWatchlistStatus(false),
    ],
    verify: (bloc) => mockRemoveWatchlist.execute(testMovieDetail),
  );

  blocTest<MovieDetailWatchlistBloc, MovieDetailWatchlistState>(
    'should update watchlist status when add watchlist failed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      when(mockGetWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((realInvocation) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistEvent(movie: testMovieDetail)),
    expect: () => [
      MovieWatchlistAddRemove('Failed'),
      MovieWatchlistStatus(true),
    ],
    verify: (bloc) => mockRemoveWatchlist.execute(testMovieDetail),
  );
}
