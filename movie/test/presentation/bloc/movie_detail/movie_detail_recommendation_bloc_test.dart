import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MovieDetailRecommendationBloc bloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = MovieDetailRecommendationBloc(mockGetMovieRecommendations);
  });

  test('Initial state should be [MovieDetailRecommendationInitial]', () {
    expect(bloc.state, MovieDetailRecommendationInitial());
  });

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'Should emit [MovieDetailRecommendationLoading, MovieDetailRecommendationLoaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieRecommendationsEvent(id: 1)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationLoaded(testMovieList),
    ],
    verify: (bloc) => mockGetMovieRecommendations.execute(1),
  );

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'Should emit [MovieDetailRecommendationLoading, MovieDetailRecommendationError] when failed to fetch data',
    build: () {
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieRecommendationsEvent(id: 1)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationError('Failed'),
    ],
    verify: (bloc) => mockGetMovieRecommendations.execute(1),
  );
}
