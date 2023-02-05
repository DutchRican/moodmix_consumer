import 'package:flutter/material.dart';

import '../logic/recommendations.dart';

class BuildFilms extends StatelessWidget {
  const BuildFilms({
    super.key,
    required this.films,
  });

  final List<Films> films;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Films:"),
        Container(
          alignment: Alignment.center,
          child: Column(
              children: films
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
  }
}
