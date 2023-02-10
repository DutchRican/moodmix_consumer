import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import 'build_albums.dart';
import 'build_films.dart';
import 'build_series.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    // if (recommendations == null) return Container();
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(
      builder: (context, state) {
        if (state is RecommendationsLoaded) {
          var recommendations = state.recommendations;
          return Flexible(
            fit: FlexFit.loose,
            flex: 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 10.0), child: Text("Mood: ${recommendations!.mood}")),
                ),
                Flexible(
                  flex: 4,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      BuildFilms(films: recommendations.films!),
                      BuildAlbums(albums: recommendations.albums!),
                      BuildSeries(series: recommendations.series!),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is RecommendationsLoading) {
          return _buildLoading();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
