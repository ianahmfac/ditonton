import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_season.dart';

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
      posterPath: json['poster_path'] != null ? '$baseImageUrl${json['poster_path']}' : null,
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
