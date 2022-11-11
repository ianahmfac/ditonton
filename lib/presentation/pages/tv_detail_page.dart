import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../domain/entities/tv_detail.dart';
import '../../injection.dart';
import '../provider/tv_detail_notifier.dart';
import '../widgets/state_widget_builder.dart';
import '../widgets/tv_episode_widget.dart';
import '../widgets/tv_season_widget.dart';

class TvDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-detail';

  final int tvId;
  const TvDetailPage({
    Key? key,
    required this.tvId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => locator<TvDetailNotifier>(),
        ),
      ],
      child: _TvDetailPageData(tvId: tvId),
    );
  }
}

class _TvDetailPageData extends StatefulWidget {
  final int tvId;
  _TvDetailPageData({
    Key? key,
    required this.tvId,
  }) : super(key: key);

  @override
  State<_TvDetailPageData> createState() => __TvDetailPageDataState();
}

class __TvDetailPageDataState extends State<_TvDetailPageData> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvDetailNotifier>()
        ..fetchDetail(widget.tvId)
        ..fetchRecommendations(widget.tvId),
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
              return _TvDetailContent(tvDetail: data.tvDetail);
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
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
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
                                onPressed: () async {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add),
                                    Text('Watchlist'),
                                  ],
                                ),
                              ),
                              Text(tvDetail.stringGenres),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tvDetail.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  SizedBox(width: 4),
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
                              SizedBox(height: 16),
                              Text('Overview', style: kHeading6),
                              Text(tvDetail.overview),
                              SizedBox(height: 16),
                              TvSeasonWidget(seasons: tvDetail.seasons),
                              SizedBox(height: 16),
                              Text('Recommendations', style: kHeading6),
                              Consumer<TvDetailNotifier>(
                                builder: (context, data, child) {
                                  final state = data.recommendationState;
                                  return StateWidgetBuilder(
                                    state: state,
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
                                                  Navigator.pushNamed(
                                                    context,
                                                    TvDetailPage.ROUTE_NAME,
                                                    arguments: tv.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: tv.posterPath ?? '',
                                                    placeholder: (context, url) => Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url, error) =>
                                                        Icon(Icons.broken_image),
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
                icon: Icon(Icons.arrow_back),
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
