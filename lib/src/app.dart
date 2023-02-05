import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mood_mix/src/screens/description.dart';
import 'package:mood_mix/src/screens/search.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MoodMix"),
        ),
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Column(children: const [
              Description(),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                flex: 4,
                child: Search(),
              )
            ])),
      ),
    );
  }
}
