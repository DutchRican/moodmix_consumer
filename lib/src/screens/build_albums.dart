import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import '../widgets/spinner.dart';

class BuildAlbums extends StatelessWidget {
  const BuildAlbums({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(builder: (context, state) {
      if (state.isChecking) {
        return const Spinner(
          item: 'albums',
        );
      } else if (state.recommendations?.films != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Albums:"),
            Container(
              alignment: Alignment.center,
              child: Column(
                  children: state.recommendations!.albums!
                      .map((item) => Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(item.album ?? ""),
                                  subtitle: Text("Artist: ${item.artist}"),
                                ),
                                ListTile(
                                  title: const Text(
                                    "Description",
                                    textScaleFactor: 0.8,
                                  ),
                                  subtitle: Text(item.albumDescription ?? ""),
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
