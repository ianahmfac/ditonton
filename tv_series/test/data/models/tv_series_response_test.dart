import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';

import '../../json_reader.dart';

void main() {
  const tTvModel = TvSeriesModel(
    backdropPath: '$baseImageUrl/path.jpg',
    id: 1,
    overview: 'Overview',
    posterPath: '$baseImageUrl/path.jpg',
    name: 'Title',
  );

  const tTvResponseModel = TvSeriesResponse(results: <TvSeriesModel>[tTvModel]);
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
            "backdrop_path": "$baseImageUrl/path.jpg",
            "id": 1,
            "overview": "Overview",
            "poster_path": "$baseImageUrl/path.jpg",
            "name": "Title"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
