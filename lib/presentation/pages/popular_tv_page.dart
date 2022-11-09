// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/popular_movies_notifier.dart';
// import '../widgets/movie_tv_card.dart';
// import '../widgets/state_widget_builder.dart';

// class PopularTvPage extends StatefulWidget {
//   static const ROUTE_NAME = '/popular-tv';

//   @override
//   _PopularTvPageState createState() => _PopularTvPageState();
// }

// class _PopularTvPageState extends State<PopularTvPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Future.microtask(
//     //     () => Provider.of<PopularMoviesNotifier>(context, listen: false).fetchPopularMovies());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Popular TV Series'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Consumer<PopularMoviesNotifier>(
//           builder: (context, data, child) {
//             return StateWidgetBuilder(
//               state: data.state,
//               loadedWidget: (context) {
//                 return ListView.builder(
//                   itemBuilder: (context, index) {
//                     final movie = data.movies[index];
//                     return MovieTvCard(movie);
//                   },
//                   itemCount: data.movies.length,
//                 );
//               },
//               errorMessage: data.message,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
