import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/exception.dart';
import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
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
}
