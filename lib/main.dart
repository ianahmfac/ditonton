import 'package:about/about.dart';
import 'package:core/common/utils.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc_export.dart';
import 'package:movie/presentation/bloc/movie_list_notifier.dart';
import 'package:movie/presentation/bloc/popular_movies_notifier.dart';
import 'package:movie/presentation/bloc/top_rated_movies_notifier.dart';
import 'package:movie/presentation/bloc/watchlist_movie_notifier.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_page.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_notifier.dart';
import 'package:tv_series/presentation/bloc/popular_tv_notifier.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_notifier.dart';
import 'package:tv_series/presentation/bloc/tv_detail_notifier.dart';
import 'package:tv_series/presentation/bloc/tv_series_list_notifier.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_notifier.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';
import 'package:tv_series/presentation/pages/now_playing_tv_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

import 'injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailWatchlistBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchBloc>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<WatchListTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<NowPlayingTvNotifier>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SearchTvBloc>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvDetailNotifier>(),
        ),
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
