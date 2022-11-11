import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;
  TvSeasonModel({
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

  TvSeasonModel copyWith({
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    int? episodeCount,
  }) {
    return TvSeasonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      episodeCount: episodeCount ?? this.episodeCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'season_number': seasonNumber,
      'episode_count': episodeCount,
    };
  }

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) {
    return TvSeasonModel(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      seasonNumber: json['season_number']?.toInt() ?? 0,
      episodeCount: json['episode_count']?.toInt() ?? 0,
    );
  }

  TvSeason toEntity() => TvSeason(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
        episodeCount: episodeCount,
      );
}
