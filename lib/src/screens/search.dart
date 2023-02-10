import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
import 'package:mood_mix/src/logic/blocs/suggestions/suggestions_bloc.dart';
import 'package:mood_mix/src/logic/models/music_brainz.dart';
import 'package:mood_mix/src/logic/resources/api_repository.dart';
import 'package:mood_mix/src/screens/recommended.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ApiRepository _apiRepository = ApiRepository();
  final RecommendationsBloc _recommendationsBloc = RecommendationsBloc();
  int tries = 0;
  Release? selectedItem;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(
      builder: (context, state) {
        if (state is RecommendationsLoading) {
          return _buildLoading();
        } else {
          return Column(
            children: [
              TypeAheadField(
                  textFieldConfiguration: const TextFieldConfiguration(
                      // autofocus: true,
                      decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  )),
                  hideOnEmpty: true,
                  hideOnLoading: true,
                  debounceDuration: const Duration(seconds: 2),
                  suggestionsCallback: (query) async {
                    return await _apiRepository.getMusicSuggestions(query);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text('${suggestion.title} - ${suggestion.artistCredit?.first.artistName}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      selectedItem = suggestion;
                      tries = 0;
                    });
                  }),
              ElevatedButton.icon(
                onPressed: selectedItem != null && !isSearching
                    ? () {}
                    : () {
                        _recommendationsBloc.add(RequestRecommendations(selectedItem!));
                        setState(() {
                          isSearching = true;
                        });
                        bool found = false;
                        // if (resp == 200) {
                        //   while (found == false && selectedItem != null) {
                        //     await Future.delayed(const Duration(milliseconds: 3000), () async {
                        //       var recommendations = await MusicSuggestions.checkResponse(selectedItem!.id);
                        //       if (recommendations != null) {
                        //         found = true;
                        //         setState(() {
                        //           _recommendations = recommendations;
                        //           debugPrint(_recommendations?.albums[0].albumDescription);
                        //           isSearching = false;
                        //         });
                        //       } else {
                        //         setState(() {
                        //           tries = tries + 1;
                        //         });
                        //       }
                        //     });
                        //   }
                        // }
                      },
                icon: isSearching
                    ? Container(
                        alignment: Alignment.center,
                        height: 24,
                        width: 24,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ))
                    : Container(),
                label: selectedItem == null
                    ? const Text(
                        "Select an Album",
                        style: TextStyle(color: Colors.grey),
                      )
                    : isSearching
                        ? const Text("")
                        : const Text("Submit"),
              ),
              Text(tries > 0 ? "Tries: $tries" : ""),
              const Recommended(),
            ],
          );
        }
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
