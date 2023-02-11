import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final String? item;
  const Spinner({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              )),
          const SizedBox(
            width: 10.0,
          ),
          Text("Fetching ${item ?? 'items'}")
        ],
      ),
    ));
  }
}
