import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;

import '../models/tv_detail_model.dart';
import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries(int page);
  Future<List<TvSeriesModel>> getTopRatedTvSeries(int page);
  Future<TvDetailModel> getTvDetail(int tvId);
  Future<List<TvSeriesModel>> getTvDetailRecommendation(int tvId);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvRemoteDataSourceImpl extends TvRemoteDataSource {
  final http.Client client;
  TvRemoteDataSourceImpl(this.client);

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries(int page) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey&page=$page'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries(int page) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey&page=$page'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int tvId) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$tvId?$apiKey'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvDetailRecommendation(int tvId) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$tvId/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/search/tv?query=$query&$apiKey'));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
