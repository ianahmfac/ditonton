import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_now_playing_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late HomeMovieNowPlayingBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    bloc = HomeMovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('Initial state should be [HomeMovieNowPlayingInitial]', () {
    expect(bloc.state, HomeMovieNowPlayingInitial());
  });

  blocTest<HomeMovieNowPlayingBloc, HomeMovieNowPlayingState>(
    'Should emit [HomeMovieNowPlayingLoading, HomeMovieNowPlayingLoaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeNowPlayingMovies()),
    expect: () => [
      HomeMovieNowPlayingLoading(),
      HomeMovieNowPlayingLoaded(nowPlayingMovies: testMovieList),
    ],
    verify: (bloc) => mockGetNowPlayingMovies.execute(),
  );

  blocTest<HomeMovieNowPlayingBloc, HomeMovieNowPlayingState>(
    'Should emit [HomeMovieNowPlayingLoading, HomeMovieNowPlayingError] when failed to fetch data',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeNowPlayingMovies()),
    expect: () => [
      HomeMovieNowPlayingLoading(),
      HomeMovieNowPlayingError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetNowPlayingMovies.execute(),
  );
}
