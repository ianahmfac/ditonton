import 'package:ditonton/common/constants.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail.dart';
import 'genre_model.dart';
import 'tv_episode_model.dart';
import 'tv_season_model.dart';

class TvDetailModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final List<GenreModel> genres;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final List<TvSeasonModel> seasons;
  final TvEpisodeModel? lastEpisode;
  final TvEpisodeModel? nextEpisode;

  TvDetailModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.genres,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
    required this.lastEpisode,
    required this.nextEpisode,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      genres,
      posterPath,
      voteAverage,
      voteCount,
      seasons,
      lastEpisode,
      nextEpisode,
    ];
  }

  TvDetailModel copyWith({
    int? id,
    String? name,
    String? overview,
    List<GenreModel>? genres,
    String? posterPath,
    double? voteAverage,
    int? voteCount,
    List<TvSeasonModel>? seasons,
    TvEpisodeModel? lastEpisode,
    TvEpisodeModel? nextEpisode,
  }) {
    return TvDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      genres: genres ?? this.genres,
      posterPath: posterPath ?? this.posterPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      seasons: seasons ?? this.seasons,
      lastEpisode: lastEpisode ?? this.lastEpisode,
      nextEpisode: nextEpisode ?? this.nextEpisode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'genres': genres.map((x) => x.toJson()).toList(),
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'seasons': seasons.map((x) => x.toJson()).toList(),
      'last_episode_to_air': lastEpisode?.toJson(),
      'next_episode_to_air': nextEpisode?.toJson(),
    };
  }

  factory TvDetailModel.fromJson(Map<String, dynamic> json) {
    return TvDetailModel(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      genres: List<GenreModel>.from(json['genres']?.map((x) => GenreModel.fromJson(x))),
      posterPath: json['poster_path'],
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count']?.toInt() ?? 0,
      seasons: List<TvSeasonModel>.from(json['seasons']?.map((x) => TvSeasonModel.fromJson(x))),
      lastEpisode: json['last_episode_to_air'] != null
          ? TvEpisodeModel.fromJson(json['last_episode_to_air'])
          : null,
      nextEpisode: json['next_episode_to_air'] != null
          ? TvEpisodeModel.fromJson(json['next_episode_to_air'])
          : null,
    );
  }

  TvDetail toEntity() => TvDetail(
        id: id,
        name: name,
        overview: overview,
        genres: genres.map((e) => e.toEntity()).toList(),
        posterPath: '$BASE_IMAGE_URL$posterPath',
        voteAverage: voteAverage,
        voteCount: voteCount,
        seasons: seasons.map((e) => e.toEntity()).toList(),
        lastEpisode: lastEpisode?.toEntity(),
        nextEpisode: nextEpisode?.toEntity(),
      );
}
