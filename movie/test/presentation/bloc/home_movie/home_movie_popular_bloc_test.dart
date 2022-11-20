import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc_export.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late HomeMoviePopularBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = HomeMoviePopularBloc(mockGetPopularMovies);
  });

  test('Initial state should be [HomeMoviePopularInitial]', () {
    expect(bloc.state, HomeMoviePopularInitial());
  });

  blocTest<HomeMoviePopularBloc, HomeMoviePopularState>(
    'Should emit [HomeMoviePopularLoading, HomeMoviePopularLoaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeMoviePopular()),
    expect: () => [
      HomeMoviePopularLoading(),
      HomeMoviePopularLoaded(popularMovies: testMovieList),
    ],
    verify: (bloc) => mockGetPopularMovies.execute(),
  );

  blocTest<HomeMoviePopularBloc, HomeMoviePopularState>(
    'Should emit [HomeMoviePopularLoading, HomeMoviePopularError] when failed to fetch data',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeMoviePopular()),
    expect: () => [
      HomeMoviePopularLoading(),
      HomeMoviePopularError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetPopularMovies.execute(),
  );
}
