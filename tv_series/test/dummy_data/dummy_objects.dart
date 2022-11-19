import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/domain/entities/tv_season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

// TV
const testTv = TvSeries(
  backdropPath: '$baseImageUrl/muth4OYamXf41G2evdrLEg8d3om.jpg',
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '$baseImageUrl/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: '$baseImageUrl/posterPath',
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
  lastEpisode: TvEpisode(
    id: 11,
    name: 'epsName',
    overview: 'overview',
    stillPath: '$baseImageUrl/stillPath',
    episodeNumber: 1,
  ),
  nextEpisode: TvEpisode(
    id: 11,
    name: 'epsName',
    overview: 'overview',
    stillPath: '$baseImageUrl/stillPath',
    episodeNumber: 1,
  ),
  seasons: [
    TvSeason(
      id: 21,
      name: 'seasonName',
      overview: 'overview',
      posterPath: '$baseImageUrl/posterPath',
      seasonNumber: 1,
      episodeCount: 1,
    ),
  ],
);

const testWatchlistTv = TvSeries(
  id: 1,
  name: 'title',
  posterPath: '$baseImageUrl/posterPath',
  overview: 'overview',
  backdropPath: null,
);

const testTvTable = TvTable(
  id: 1,
  title: 'title',
  posterPath: '$baseImageUrl/posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': '$baseImageUrl/posterPath',
  'title': 'title',
};
