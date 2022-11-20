import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late WatchlistMovieBloc bloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  test('Initial state should be [WatchlistMovieInitial]', () {
    expect(bloc.state, WatchlistMovieInitial());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [WatchlistMovieLoading, WatchlistMovieLoaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieLoaded(watchlistMovies: testMovieList),
    ],
    verify: (bloc) => mockGetWatchlistMovies.execute(),
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [WatchlistMovieLoading, WatchlistMovieError] when failed to fetch data',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetWatchlistMovies.execute(),
  );
}
