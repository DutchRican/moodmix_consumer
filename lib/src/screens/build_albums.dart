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
            ListTile(
              leading: const Icon(Icons.music_note),
              title: Center(
                child: Text(
                  "Albums",
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey[800], fontWeight: FontWeight.w500),
                ),
              ),
              trailing: const Icon(Icons.music_note),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Column(
                  children: state.recommendations!.albums!
                      .map((item) => Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(item.album ?? ""),
                                  subtitle: Text("Artist: ${item.artist ?? 'not listed'}"),
                                ),
                                item.albumDescription != null
                                    ? ListTile(
                                        title: const Text(
                                          "Description",
                                          textScaleFactor: 0.8,
                                        ),
                                        subtitle: Text(item.albumDescription ?? ""),
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
