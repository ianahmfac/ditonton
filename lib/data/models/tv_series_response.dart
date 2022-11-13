import 'package:equatable/equatable.dart';

import 'tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> results;
  TvSeriesResponse({
    required this.results,
  });
  @override
  List<Object> get props => [results];

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((x) => x.toJson()).toList(),
    };
  }

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesResponse(
      results: List<TvSeriesModel>.from((json['results'] as List? ?? [])
          .map((x) => TvSeriesModel.fromJson(x))
          .where((element) => element.posterPath != null)),
    );
  }

  @override
  String toString() => 'TvSeriesResponse(results: $results)';
}
