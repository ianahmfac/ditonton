import 'package:core/data/datasources/db/database_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
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
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc_export.dart';
import 'package:movie/presentation/bloc/popular_movies_notifier.dart';
import 'package:movie/presentation/bloc/top_rated_movies_notifier.dart';
import 'package:movie/presentation/bloc/watchlist_movie_notifier.dart';
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
import 'package:tv_series/presentation/bloc/now_playing_tv_notifier.dart';
import 'package:tv_series/presentation/bloc/popular_tv_notifier.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_notifier.dart';
import 'package:tv_series/presentation/bloc/tv_detail_notifier.dart';
import 'package:tv_series/presentation/bloc/tv_series_list_notifier.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_notifier.dart';

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
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(() => PopularTvNotifier(getPopularTvSeries: locator()));
  locator.registerFactory(() => TopRatedTvNotifier(getTopRatedTvSeries: locator()));
  locator.registerFactory(() => TvDetailNotifier(
        getTvDetail: locator(),
        getTvDetailRecommendation: locator(),
        getWatchlistTvStatus: locator(),
        removeWatchListTv: locator(),
        saveWatchlistTv: locator(),
      ));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => WatchListTvNotifier(getWatchListTv: locator()));
  locator.registerFactory(() => NowPlayingTvNotifier(getNowPlayingTvSeries: locator()));

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
  locator.registerLazySingleton(() => http.Client());
}
