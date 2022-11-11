import 'package:equatable/equatable.dart';

import 'genre.dart';
import 'tv_episode.dart';
import 'tv_season.dart';

class TvDetail extends Equatable {
  final int id;
  final String name;
  final String overview;
  final List<Genre> genres;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final List<TvSeason> seasons;
  final TvEpisode? lastEpisode;
  final TvEpisode? nextEpisode;
  TvDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.genres,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
    required this.lastEpisode,
    required this.nextEpisode,
  });

  String get stringGenres {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

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

  TvDetail copyWith({
    int? id,
    String? name,
    String? overview,
    List<Genre>? genres,
    String? posterPath,
    double? voteAverage,
    int? voteCount,
    List<TvSeason>? seasons,
    TvEpisode? lastEpisode,
    TvEpisode? nextEpisode,
  }) {
    return TvDetail(
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
}
