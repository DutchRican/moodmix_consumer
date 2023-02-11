import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import 'package:mood_mix/src/widgets/spinner.dart';

class BuildFilms extends StatelessWidget {
  const BuildFilms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(builder: (context, state) {
      if (state.isChecking) {
        return const Spinner(item: 'films');
      } else if (state.recommendations?.films != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Films:"),
            Container(
              alignment: Alignment.center,
              child: Column(
                  children: state.recommendations!.films!
                      .map((film) => Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(film.film ?? ""),
                                  subtitle: Text("Director: ${film.director ?? "not listed"}"),
                                ),
                                ListTile(
                                  title: const Text(
                                    "Description",
                                    textScaleFactor: 0.8,
                                  ),
                                  subtitle: Text(film.filmDescription ?? ""),
                                ),
                              ],
                            ),
                          ))
                      .toList()),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
