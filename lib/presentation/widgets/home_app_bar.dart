import 'package:flutter/material.dart';

import '../pages/search_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const HomeAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
          },
          icon: Icon(Icons.search),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
