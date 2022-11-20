import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late PopularMovieBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('Initial state should be [PopularMovieInitial]', () {
    expect(bloc.state, PopularMovieInitial());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [PopularMovieLoading, PopularMovieLoaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieLoaded(popularMovies: testMovieList),
    ],
    verify: (bloc) => mockGetPopularMovies.execute(),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [PopularMovieLoading, PopularMovieError] when failed to fetch data',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetPopularMovies.execute(),
  );
}
