import 'package:flutter/material.dart';

import '../logic/recommendations.dart';

class BuildSeries extends StatelessWidget {
  const BuildSeries({
    super.key,
    required this.series,
  });

  final List<Series> series;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Films:"),
        Container(
          alignment: Alignment.center,
          child: Column(
              children: series
                  .map((item) => Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(item.series ?? ""),
                              subtitle: Text("Director: ${item.creators}"),
                            ),
                            ListTile(
                              title: const Text(
                                "Description",
                                textScaleFactor: 0.8,
                              ),
                              subtitle: Text(item.seriesDescription ?? ""),
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
