import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? backdropPath;
  final String? posterPath;
  TvSeries({
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

  TvSeries copyWith({
    int? id,
    String? name,
    String? overview,
    String? backdropPath,
    String? posterPath,
  }) {
    return TvSeries(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
    );
  }

  @override
  String toString() {
    return 'TvSeries(id: $id, name: $name, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath)';
  }
}
