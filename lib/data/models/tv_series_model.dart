import 'package:equatable/equatable.dart';

import '../../common/constants.dart';
import '../../domain/entities/tv_series.dart';

class TvSeriesModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? backdropPath;
  final String? posterPath;

  TvSeriesModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      backdropPath,
      posterPath,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
    };
  }

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      backdropPath:
          json['backdrop_path'] != null ? '$BASE_IMAGE_URL${json['backdrop_path']}' : null,
      posterPath: json['poster_path'] != null ? '$BASE_IMAGE_URL${json['poster_path']}' : null,
    );
  }

  TvSeries toEntity() {
    return TvSeries(
      id: this.id,
      name: this.name,
      overview: this.overview,
      backdropPath: this.backdropPath,
      posterPath: this.posterPath,
    );
  }

  @override
  String toString() {
    return 'TvSeriesModel(id: $id, name: $name, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath)';
  }
}
