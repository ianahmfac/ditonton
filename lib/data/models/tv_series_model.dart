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

  TvSeriesModel copyWith({
    int? id,
    String? name,
    String? overview,
    String? backdropPath,
    String? posterPath,
  }) {
    return TvSeriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'backdropPath': backdropPath,
      'posterPath': posterPath,
    };
  }

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
    );
  }

  TvSeries toEntity() {
    return TvSeries(
      id: this.id,
      name: this.name,
      overview: this.overview,
      backdropPath: this.backdropPath != null ? '$BASE_IMAGE_URL${this.backdropPath}' : null,
      posterPath: this.posterPath != null ? '$BASE_IMAGE_URL${this.posterPath}' : null,
    );
  }

  @override
  String toString() {
    return 'TvSeriesModel(id: $id, name: $name, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath)';
  }
}
