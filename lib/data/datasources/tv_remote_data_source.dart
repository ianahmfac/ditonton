import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/exception.dart';
import '../models/tv_detail_model.dart';
import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries(int page);
  Future<List<TvSeriesModel>> getTopRatedTvSeries(int page);
  Future<TvDetailModel> getTvDetail(int tvId);
  Future<List<TvSeriesModel>> getTvDetailRecommendation(int tvId);
}

class TvRemoteDataSourceImpl extends TvRemoteDataSource {
  final http.Client client;
  TvRemoteDataSourceImpl(this.client);

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries(int page) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY&page=$page'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries(int page) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY&page=$page'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int tvId) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$tvId?$API_KEY'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvDetailRecommendation(int tvId) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$tvId/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
