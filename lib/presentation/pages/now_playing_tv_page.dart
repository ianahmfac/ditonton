import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/now_playing_tv_notifier.dart';
import '../widgets/movie_tv_card.dart';
import '../widgets/state_widget_builder.dart';
import 'tv_detail_page.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _NowPlayingTvPageState createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NowPlayingTvNotifier>().fetchNowPlaying());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Airing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvNotifier>(
          builder: (context, data, child) {
            return StateWidgetBuilder(
              state: data.state,
              loadedWidget: (context) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = data.tvSeries[index];
                    return MovieTvCard(
                      onTap: () => Navigator.pushNamed(
                        context,
                        TvDetailPage.ROUTE_NAME,
                        arguments: tv.id,
                      ),
                      title: tv.name,
                      overview: tv.overview,
                      posterPath: tv.posterPath ?? '',
                    );
                  },
                  itemCount: data.tvSeries.length,
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
