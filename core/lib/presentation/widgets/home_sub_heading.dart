import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HomeSubHeading extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const HomeSubHeading({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: kHeading6),
        ),
        if (onTap != null)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
