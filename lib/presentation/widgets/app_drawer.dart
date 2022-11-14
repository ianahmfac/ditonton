import 'package:about/about.dart';
import 'package:flutter/material.dart';

import '../pages/watchlist_page.dart';

class AppDrawer extends StatelessWidget {
  final void Function() onMovieClick;
  final void Function() onTvClick;
  const AppDrawer({
    Key? key,
    required this.onMovieClick,
    required this.onTvClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ian Ahmad Fachriza'),
            accountEmail: Text('ianahmadfachriza6@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: onMovieClick,
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Tv Series'),
            onTap: onTvClick,
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
