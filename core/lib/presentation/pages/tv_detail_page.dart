// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/tv_detail.dart';
import '../provider/tv_detail_notifier.dart';
import '../widgets/state_widget_builder.dart';
import '../widgets/tv_episode_widget.dart';
import '../widgets/tv_season_widget.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/tv-detail';

  final int tvId;
  const TvDetailPage({
    Key? key,
    required this.tvId,
  }) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvDetailNotifier>()
        ..fetchDetail(widget.tvId)
        ..fetchRecommendations(widget.tvId)
        ..loadWatchlistStatus(widget.tvId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, data, child) {
          final state = data.detailState;
          return StateWidgetBuilder(
            state: state,
            loadedWidget: (context) {
              return _TvDetailContent(
                tvDetail: data.tvDetail,
                isOnWatchList: data.isAddedToWatchlist,
              );
            },
            errorMessage: data.message,
          );
        },
      ),
    );
  }
}

class _TvDetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final bool isOnWatchList;
  const _TvDetailContent({
    Key? key,
    required this.tvDetail,
    required this.isOnWatchList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: tvDetail.posterPath ?? '',
            width: screenWidth,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tvDetail.name, style: kHeading5),
                              ElevatedButton(
                                onPressed: () async {
                                  if (isOnWatchList) {
                                    await context
                                        .read<TvDetailNotifier>()
                                        .removeWatchList(tvDetail);
                                  } else {
                                    await context.read<TvDetailNotifier>().addWatchlist(tvDetail);
                                  }

                                  final message = context.read<TvDetailNotifier>().watchlistMessage;
                                  if (message == watchlistAddSuccessMessage ||
                                      message == watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(message)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        });
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(isOnWatchList ? Icons.check : Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              ),
                              Text(tvDetail.stringGenres),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tvDetail.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text('${tvDetail.voteCount}')),
                                ],
                              ),
                              if (tvDetail.nextEpisode != null)
                                TvEpisodeWidget(
                                  title: 'Next Episode',
                                  tvEps: tvDetail.nextEpisode,
                                ),
                              if (tvDetail.lastEpisode != null)
                                TvEpisodeWidget(
                                  title: 'Last Episode',
                                  tvEps: tvDetail.lastEpisode,
                                ),
                              const SizedBox(height: 16),
                              Text('Overview', style: kHeading6),
                              Text(tvDetail.overview),
                              const SizedBox(height: 16),
                              TvSeasonWidget(seasons: tvDetail.seasons),
                              const SizedBox(height: 16),
                              Text('Recommendations', style: kHeading6),
                              Consumer<TvDetailNotifier>(
                                builder: (context, data, child) {
                                  final state = data.recommendationState;
                                  return StateWidgetBuilder(
                                    state: state,
                                    errorMessage: data.message,
                                    loadedWidget: (context) {
                                      return SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final tv = data.recommendations[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushReplacementNamed(
                                                    context,
                                                    TvDetailPage.routeName,
                                                    arguments: tv.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: tv.posterPath ?? '',
                                                    placeholder: (context, url) => const Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url, error) =>
                                                        const Icon(Icons.broken_image),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: data.recommendations.length,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              minChildSize: 0.25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}