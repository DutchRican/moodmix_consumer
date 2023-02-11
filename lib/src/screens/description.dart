import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "Moodmix is an AI media recommender using ChatGPT. It suggests films, music, and movies based on the album you're playing.",
            style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 15.0),
        Text("Note: It may take up to 60 seconds for the AI model to complete your request",
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
