import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeListWidget extends StatelessWidget {
  const HomeListWidget({
    Key? key,
    required this.onTap,
    required this.posterPath,
  }) : super(key: key);

  final void Function() onTap;
  final String? posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: posterPath ?? '',
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
