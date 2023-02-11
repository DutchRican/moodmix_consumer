import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      width: double.infinity,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: const EdgeInsets.only(bottom: 15, top: 5),
          child: Column(
            children: const [
              Text("© 2023 Moodmix", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("Built with ❤️ by Matthew Stingel in Denver, CO ⛰️",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
