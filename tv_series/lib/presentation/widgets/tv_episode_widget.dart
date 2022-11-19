import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_episode.dart';

class TvEpisodeWidget extends StatelessWidget {
  const TvEpisodeWidget({
    Key? key,
    required this.title,
    required this.tvEps,
  }) : super(key: key);

  final String title;
  final TvEpisode? tvEps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kHeading6),
          const SizedBox(height: 2),
          Card(
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: tvEps?.stillPath ?? '',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eps ${tvEps?.episodeNumber}: ${tvEps?.name}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (tvEps?.overview != '') ...[
                        const SizedBox(height: 2),
                        Text(tvEps?.overview ?? '')
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
