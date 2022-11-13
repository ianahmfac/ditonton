import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail.dart';
import '../../domain/entities/tv_series.dart';

class TvTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TvTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  @override
  List<Object?> get props => [id, title, posterPath, overview];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  factory TvTable.fromJson(Map<String, dynamic> json) {
    return TvTable(
      id: json['id']?.toInt() ?? 0,
      title: json['title'],
      posterPath: json['posterPath'],
      overview: json['overview'],
    );
  }

  factory TvTable.fromEntity(TvDetail tv) {
    return TvTable(
      id: tv.id,
      title: tv.name,
      posterPath: tv.posterPath,
      overview: tv.overview,
    );
  }

  TvSeries toEntity() => TvSeries(
        id: id,
        name: title ?? '',
        overview: overview ?? '',
        backdropPath: null,
        posterPath: posterPath,
      );
}
