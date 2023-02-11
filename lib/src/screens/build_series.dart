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
            ListTile(
              leading: const Icon(Icons.camera),
              title: Center(
                child: Text(
                  "Series:",
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey[800], fontWeight: FontWeight.w500),
                ),
              ),
              trailing: const Icon(Icons.camera),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                  children: state.recommendations!.series!
                      .map((item) => Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(item.series ?? ""),
                                  subtitle: Text("Director: ${item.creators ?? 'not listed'}"),
                                ),
                                item.seriesDescription != null
                                    ? ListTile(
                                        title: const Text(
                                          "Description",
                                          textScaleFactor: 0.8,
                                        ),
                                        subtitle: Text(item.seriesDescription ?? ""),
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
