import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import 'package:mood_mix/src/widgets/spinner.dart';
import 'build_albums.dart';
import 'build_films.dart';
import 'build_series.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(builder: (context, state) {
      var mood = state.recommendations?.mood;
      return Flexible(
        fit: FlexFit.loose,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                  child: mood != null ? Text('Mood: "$mood"') : Container()),
            ),
            Flexible(
              flex: 4,
              child: !state.isLoading
                  ? ListView(
                      shrinkWrap: true,
                      children: const [
                        BuildFilms(),
                        BuildAlbums(),
                        BuildSeries(),
                      ],
                    )
                  : const Spinner(
                      item: "recommendations",
                    ),
            ),
          ],
        ),
      );
    });
  }
}
