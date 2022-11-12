import 'dart:convert';

import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(mockHttpClient);
  });

  group('get Now Playing Tv Series', () {
    final tTvList =
        TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/now_playing_tv.json'))).results;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/now_playing_tv.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTvSeries();
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tTvList =
        TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json'))).results;

    test('should return list of tv when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY&page=1')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/popular_tv.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries(1);
      // assert
      expect(result, tTvList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY&page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries(1);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tTvList =
        TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/top_rated_tv.json'))).results;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY&page=1')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries(1);
      // assert
      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY&page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries(1);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvDetail = TvDetailModel.fromJson(json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList =
        TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/tv_recommendations.json')))
            .results;
    final tId = 1;

    test('should return list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvDetailRecommendation(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetailRecommendation(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult =
        TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/search_spiderman_tv.json')))
            .results;
    final tQuery = 'Spiderman';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?query=$tQuery&$API_KEY'))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/search_spiderman_tv.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?query=$tQuery&$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
