import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late TopRatedMovieBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('Initial state should be [TopRatedMovieInitial]', () {
    expect(bloc.state, TopRatedMovieInitial());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [TopRatedMovieLoading, TopRatedMovieLoaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieLoaded(topRatedMovies: testMovieList),
    ],
    verify: (bloc) => mockGetTopRatedMovies.execute(),
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [TopRatedMovieLoading, TopRatedMovieError] when failed to fetch data',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetTopRatedMoviesEvent()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetTopRatedMovies.execute(),
  );
}
