import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc_export.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late HomeMovieTopRatedBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = HomeMovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test('Initial state should be [HomeMovieTopRatedInitial]', () {
    expect(bloc.state, HomeMovieTopRatedInitial());
  });

  blocTest<HomeMovieTopRatedBloc, HomeMovieTopRatedState>(
    'Should emit [HomeMovieTopRatedLoading, HomeMovieTopRatedLoaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeMovieTopRated()),
    expect: () => [
      HomeMovieTopRatedLoading(),
      HomeMovieTopRatedLoaded(topRatedMovies: testMovieList),
    ],
    verify: (bloc) => mockGetTopRatedMovies.execute(),
  );

  blocTest<HomeMovieTopRatedBloc, HomeMovieTopRatedState>(
    'Should emit [HomeMovieTopRatedLoading, HomeMovieTopRatedError] when failed to fetch data',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetHomeMovieTopRated()),
    expect: () => [
      HomeMovieTopRatedLoading(),
      HomeMovieTopRatedError(message: 'Failed'),
    ],
    verify: (bloc) => mockGetTopRatedMovies.execute(),
  );
}
