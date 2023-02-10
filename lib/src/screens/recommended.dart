import 'package:flutter/material.dart';
import '../logic/models/recommendations.dart';
import 'build_albums.dart';
import 'build_films.dart';
import 'build_series.dart';

class Recommended extends StatelessWidget {
  Recommended({super.key, required this.recommendations});
  late Recommendations? recommendations;

  @override
  Widget build(BuildContext context) {
    if (recommendations == null) return Container();
    return Flexible(
      fit: FlexFit.loose,
      flex: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 0,
            child:
                Container(padding: const EdgeInsets.only(bottom: 10.0), child: Text("Mood: ${recommendations!.mood}")),
          ),
          Flexible(
            flex: 4,
            child: ListView(
              shrinkWrap: true,
              children: [
                BuildFilms(films: recommendations!.films),
                BuildAlbums(albums: recommendations!.albums),
                BuildSeries(series: recommendations!.series),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
