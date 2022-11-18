import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvBloc = SearchTvBloc(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchTvEmpty());
  });

  const tTv = TvSeries(
    backdropPath: '$baseImageUrl/muth4OYamXf41G2evdrLEg8d3om.jpg',
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '$baseImageUrl/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'Spider-Man',
  );
  final tTvList = <TvSeries>[tTv];
  const tQuery = 'spiderman';

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery)).thenAnswer((realInvocation) async => Right(tTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
  );

  blocTest(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((realInvocation) async => const Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    wait: const Duration(seconds: 1),
    expect: () => [
      SearchTvLoading(),
      const SearchTvError('Server Failure'),
    ],
    verify: (bloc) => mockSearchTvSeries.execute(tQuery),
  );
}
