import 'package:equatable/equatable.dart';

import '../../common/constants.dart';
import '../../domain/entities/tv_episode.dart';

class TvEpisodeModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final int episodeNumber;
  TvEpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.stillPath,
    required this.episodeNumber,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      stillPath,
      episodeNumber,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'still_path': stillPath,
      'episode_number': episodeNumber,
    };
  }

  factory TvEpisodeModel.fromJson(Map<String, dynamic> json) {
    return TvEpisodeModel(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      stillPath: json['still_path'] != null ? '$BASE_IMAGE_URL${json['still_path']}' : null,
      episodeNumber: json['episode_number']?.toInt() ?? 0,
    );
  }

  TvEpisode toEntity() => TvEpisode(
        id: id,
        name: name,
        overview: overview,
        stillPath: stillPath,
        episodeNumber: episodeNumber,
      );
}
