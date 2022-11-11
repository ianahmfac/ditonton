import 'package:equatable/equatable.dart';

class TvEpisode extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final int episodeNumber;
  TvEpisode({
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

  TvEpisode copyWith({
    int? id,
    String? name,
    String? overview,
    String? stillPath,
    int? episodeNumber,
  }) {
    return TvEpisode(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      stillPath: stillPath ?? this.stillPath,
      episodeNumber: episodeNumber ?? this.episodeNumber,
    );
  }
}
