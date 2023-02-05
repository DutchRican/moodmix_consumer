import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: const [
          Text(
              "Moodmix is an AI media recommender using ChatGPT. It suggests films, music, and movies based on the album you're playing."),
          SizedBox(height: 15.0),
          Text("Note: It may take up to 60 seconds for the AI model to complete your request"),
        ],
      ),
    );
  }
}
