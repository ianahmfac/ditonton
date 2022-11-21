// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc_export.dart';

import '../../domain/entities/tv_detail.dart';
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
    Future.microtask(() {
      context.read<TvDetailBloc>().add(GetTvDetailEvent(id: widget.tvId));
      context
          .read<TvDetailRecommendationBloc>()
          .add(GetTvDetailRecommendationEvent(id: widget.tvId));
      context.read<TvDetailWatchlistBloc>().add(GetWatchListTvStatusEvent(id: widget.tvId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            return _TvDetailContent(tvDetail: state.tvDetail);
          } else if (state is TvDetailError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _TvDetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  const _TvDetailContent({
    Key? key,
    required this.tvDetail,
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
                              BlocConsumer<TvDetailWatchlistBloc, TvDetailWatchlistState>(
                                buildWhen: (previous, current) => current is TvWatchlistStatus,
                                listener: (context, state) {
                                  if (state is TvWatchlistAddRemove) {
                                    final message = state.message;
                                    if (message == watchlistAddSuccessMessage ||
                                        message == watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(content: Text(message));
                                        },
                                      );
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  final isOnWatchList =
                                      (state as TvWatchlistStatus).isAddToWatchlist;
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (isOnWatchList) {
                                        context
                                            .read<TvDetailWatchlistBloc>()
                                            .add(RemoveWatchlistTvEvent(tvDetail: tvDetail));
                                      } else {
                                        context
                                            .read<TvDetailWatchlistBloc>()
                                            .add(SaveWatchlistTvEvent(tvDetail: tvDetail));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(isOnWatchList ? Icons.check : Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
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
                              BlocBuilder<TvDetailRecommendationBloc, TvDetailRecommendationState>(
                                builder: (context, state) {
                                  if (state is TvDetailRecommendationLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is TvDetailRecommendationLoaded) {
                                    return SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final tv = state.recommendations[index];
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
                                        itemCount: state.recommendations.length,
                                      ),
                                    );
                                  } else if (state is TvDetailRecommendationError) {
                                    return Center(
                                      key: const Key('error_message'),
                                      child: Text(state.message),
                                    );
                                  }
                                  return Container();
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
