import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/http_ssl_pinning.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc_export.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:tv_series/data/datasources/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_detail_recommendation.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rate_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc_export.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => HomeMovieNowPlayingBloc(locator()));
  locator.registerFactory(() => HomeMoviePopularBloc(locator()));
  locator.registerFactory(() => HomeMovieTopRatedBloc(locator()));

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailRecommendationBloc(locator()),
  );
  locator.registerFactory(
    () => MovieDetailWatchlistBloc(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => SearchBloc(locator()),
  );

  locator.registerFactory(() => PopularMovieBloc(locator()));

  locator.registerFactory(() => TopRatedMovieBloc(locator()));

  locator.registerFactory(() => WatchlistMovieBloc(locator()));

  locator.registerFactory(() => HomeTvNowPlayingBloc(locator()));
  locator.registerFactory(() => HomeTvPopularBloc(locator()));
  locator.registerFactory(() => HomeTvTopRatedBloc(locator()));

  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));

  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => TvDetailRecommendationBloc(locator()));
  locator.registerFactory(() => TvDetailWatchlistBloc(locator(), locator(), locator()));

  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(repository: locator()));
  locator.registerLazySingleton(() => GetTvDetail(tvSeriesRepository: locator()));
  locator.registerLazySingleton(() => GetTvDetailRecommendation(tvSeriesRepository: locator()));
  locator.registerLazySingleton(() => SearchTvSeries(tvSeriesRepository: locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(tvSeriesRepository: locator()));
  locator.registerLazySingleton(() => RemoveWatchListTv(tvSeriesRepository: locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(tvSeriesRepository: locator()));
  locator.registerLazySingleton(() => GetWatchListTv(tvSeriesRepository: locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
