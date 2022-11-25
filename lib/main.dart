import 'package:about/about.dart';
import 'package:core/common/utils.dart';
import 'package:core/core.dart';
import 'package:core/utils/http_ssl_pinning.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/home_movie/home_movie_bloc_export.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';
import 'package:movie/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_page.dart';
import 'package:search/search.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_now_playing_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/home_tv/home_tv_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rate_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc_export.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';
import 'package:tv_series/presentation/pages/now_playing_tv_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<HomeMovieNowPlayingBloc>()),
        BlocProvider(create: (context) => di.locator<HomeMoviePopularBloc>()),
        BlocProvider(create: (context) => di.locator<HomeMovieTopRatedBloc>()),
        BlocProvider(create: (context) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (context) => di.locator<MovieDetailRecommendationBloc>()),
        BlocProvider(create: (context) => di.locator<MovieDetailWatchlistBloc>()),
        BlocProvider(create: (context) => di.locator<SearchBloc>()),
        BlocProvider(create: (context) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (context) => di.locator<HomeTvNowPlayingBloc>()),
        BlocProvider(create: (context) => di.locator<HomeTvPopularBloc>()),
        BlocProvider(create: (context) => di.locator<HomeTvTopRatedBloc>()),
        BlocProvider(create: (context) => di.locator<NowPlayingTvBloc>()),
        BlocProvider(create: (context) => di.locator<PopularTvBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedTvBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistTvBloc>()),
        BlocProvider(create: (context) => di.locator<SearchTvBloc>()),
        BlocProvider(create: (context) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (context) => di.locator<TvDetailRecommendationBloc>()),
        BlocProvider(create: (context) => di.locator<TvDetailWatchlistBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvPage.routeName:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case PopularTvPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case TopRatedTvPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int?;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(tvId: id ?? 0),
              );
            case SearchTvPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case NowPlayingTvPage.routeName:
              return MaterialPageRoute(builder: (_) => NowPlayingTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
