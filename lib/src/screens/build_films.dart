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
            ListTile(
              leading: const Icon(Icons.movie),
              title: Center(
                child: Text(
                  "Films",
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey[800], fontWeight: FontWeight.w500),
                ),
              ),
              trailing: const Icon(Icons.movie),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                  children: state.recommendations!.films!
                      .map((film) => Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(film.film ?? ""),
                                  subtitle: Text("Director: ${film.director ?? "not listed"}"),
                                ),
                                film.filmDescription != null
                                    ? ListTile(
                                        title: const Text(
                                          "Description",
                                          textScaleFactor: 0.8,
                                        ),
                                        subtitle: Text(film.filmDescription ?? ""),
                                      )
                                    : Container(),
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
