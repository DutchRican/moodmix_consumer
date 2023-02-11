import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import '../widgets/spinner.dart';

class BuildSeries extends StatelessWidget {
  const BuildSeries({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(builder: (context, state) {
      if (state.isChecking) {
        return const Spinner(
          item: 'series',
        );
      } else if (state.recommendations?.series != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Films:"),
            Container(
              alignment: Alignment.center,
              child: Column(
                  children: state.recommendations!.series!
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
      } else {
        return Container();
      }
    });
  }
}
