import 'dart:convert';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvSeriesModel(
    backdropPath: '$BASE_IMAGE_URL/path.jpg',
    id: 1,
    overview: 'Overview',
    posterPath: '$BASE_IMAGE_URL/path.jpg',
    name: 'Title',
  );

  final tTvResponseModel = TvSeriesResponse(results: <TvSeriesModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "$BASE_IMAGE_URL/path.jpg",
            "id": 1,
            "overview": "Overview",
            "poster_path": "$BASE_IMAGE_URL/path.jpg",
            "name": "Title"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
