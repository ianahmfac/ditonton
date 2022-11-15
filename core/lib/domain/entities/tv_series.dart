import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String? backdropPath;
  final String? posterPath;
  const TvSeries({
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
}
