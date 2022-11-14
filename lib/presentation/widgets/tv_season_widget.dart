import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_season.dart';

class TvSeasonWidget extends StatelessWidget {
  const TvSeasonWidget({
    Key? key,
    required this.seasons,
  }) : super(key: key);

  final List<TvSeason> seasons;

  @override
  Widget build(BuildContext context) {
    return seasons.isEmpty
        ? SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Seasons', style: kHeading6),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final season = seasons[index];
                    return Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SizedBox(
                        width: 250,
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.black,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Opacity(
                                  opacity: 0.3,
                                  child: CachedNetworkImage(
                                    imageUrl: season.posterPath ?? '',
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.broken_image_sharp),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${season.seasonNumber} - ${season.name}',
                                    style: kSubtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('${season.episodeCount} eps'),
                                  if (season.overview.isNotEmpty)
                                    Text(
                                      season.overview,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: seasons.length,
                ),
              ),
            ],
          );
  }
}
