import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

// TV
final testTv = TvSeries(
  backdropPath: '$BASE_IMAGE_URL/muth4OYamXf41G2evdrLEg8d3om.jpg',
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '$BASE_IMAGE_URL/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  name: 'Spider-Man',
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: '$BASE_IMAGE_URL/posterPath',
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
  lastEpisode: TvEpisode(
    id: 11,
    name: 'epsName',
    overview: 'overview',
    stillPath: '$BASE_IMAGE_URL/stillPath',
    episodeNumber: 1,
  ),
  nextEpisode: TvEpisode(
    id: 11,
    name: 'epsName',
    overview: 'overview',
    stillPath: '$BASE_IMAGE_URL/stillPath',
    episodeNumber: 1,
  ),
  seasons: [
    TvSeason(
      id: 21,
      name: 'seasonName',
      overview: 'overview',
      posterPath: '$BASE_IMAGE_URL/posterPath',
      seasonNumber: 1,
      episodeCount: 1,
    ),
  ],
);

final testWatchlistTv = TvSeries(
  id: 1,
  name: 'title',
  posterPath: '$BASE_IMAGE_URL/posterPath',
  overview: 'overview',
  backdropPath: null,
);

final testTvTable = TvTable(
  id: 1,
  title: 'title',
  posterPath: '$BASE_IMAGE_URL/posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': '$BASE_IMAGE_URL/posterPath',
  'title': 'title',
};
