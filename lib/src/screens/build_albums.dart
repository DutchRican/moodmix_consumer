import 'package:flutter/material.dart';

import '../logic/recommendations.dart';

class BuildAlbums extends StatelessWidget {
  const BuildAlbums({
    super.key,
    required this.albums,
  });

  final List<Albums> albums;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Albums:"),
        Container(
          alignment: Alignment.center,
          child: Column(
              children: albums
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
  }
}
