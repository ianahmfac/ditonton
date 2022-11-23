import 'package:core/presentation/widgets/movie_tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';

import 'tv_detail_page.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const routeName = '/now-playing-tv';

  const NowPlayingTvPage({super.key});

  @override
  State<NowPlayingTvPage> createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NowPlayingTvBloc>().add(GetNowPlayingTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Airing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
          builder: (context, state) {
            if (state is NowPlayingTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvSeries[index];
                  return MovieTvCard(
                    onTap: () => Navigator.pushNamed(
                      context,
                      TvDetailPage.routeName,
                      arguments: tv.id,
                    ),
                    title: tv.name,
                    overview: tv.overview,
                    posterPath: tv.posterPath ?? '',
                  );
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is NowPlayingTvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
