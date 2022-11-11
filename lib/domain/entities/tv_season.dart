import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;
  TvSeason({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodeCount,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      posterPath,
      seasonNumber,
      episodeCount,
    ];
  }

  TvSeason copyWith({
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    int? episodeCount,
  }) {
    return TvSeason(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      episodeCount: episodeCount ?? this.episodeCount,
    );
  }
}
