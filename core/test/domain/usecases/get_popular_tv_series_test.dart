import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(repository: mockRepository);
  });

  final tTv = <TvSeries>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test('should get list of tv from the repository when execute function is called', () async {
        // arrange
        when(mockRepository.getPopularTvSeries(1)).thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase.execute(1);
        // assert
        expect(result, Right(tTv));
      });
    });
  });
}
