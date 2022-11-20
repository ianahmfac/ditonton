import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  test('Initial state should be [MovieDetailInitial]', () {
    expect(bloc.state, MovieDetailInitial());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [MovieDetailLoading, MovieDetailLoaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((realInvocation) async => const Right(testMovieDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailEvent(id: 1)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(testMovieDetail),
    ],
    verify: (bloc) => mockGetMovieDetail.execute(1),
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [MovieDetailLoading, MovieDetailError] when failed to fetch data',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieDetailEvent(id: 1)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailError('Failed'),
    ],
    verify: (bloc) => mockGetMovieDetail.execute(1),
  );
}
