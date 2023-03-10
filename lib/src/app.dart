import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import 'package:mood_mix/src/screens/description.dart';
import 'package:mood_mix/src/screens/search.dart';
import 'package:mood_mix/src/widgets/footer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => RecommendationsBloc(),
        ),
        // BlocProvider(create: (BuildContext context) => Sugg)
      ],
      child: MaterialApp(
        title: "test",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("MoodMix"),
          ),
          body: BlocListener<RecommendationsBloc, RecommendationsState>(
            listener: (context, state) {
              if (state.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    // direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Description(),
                      SizedBox(
                        height: 10.0,
                      ),
                      // Search(),
                      Expanded(
                        flex: 4,
                        child: Search(),
                      ),
                    ],
                  ),
                ),
                Container(alignment: Alignment.bottomCenter, child: const Footer()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
