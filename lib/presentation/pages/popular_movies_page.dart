import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../provider/popular_movies_notifier.dart';
import '../widgets/movie_tv_card.dart';
import '../widgets/state_widget_builder.dart';
import 'movie_detail_page.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<PopularMoviesNotifier>(context, listen: false).fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularMoviesNotifier>(
          builder: (context, data, child) {
            return StateWidgetBuilder(
              state: data.state,
              loadedWidget: (context) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return MovieTvCard(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailPage.ROUTE_NAME,
                          arguments: movie.id,
                        );
                      },
                      title: movie.title ?? '-',
                      overview: movie.overview ?? '-',
                      posterPath: '$BASE_IMAGE_URL/${movie.posterPath}',
                    );
                  },
                  itemCount: data.movies.length,
                );
              },
              errorMessage: data.message,
            );
          },
        ),
      ),
    );
  }
}
