import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mood_mix/src/logic/recommendations.dart';
import 'package:mood_mix/src/logic/suggestions.dart';
import 'package:mood_mix/src/logic/music.dart';
import 'package:mood_mix/src/screens/recommended.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Release? selectedItem;
  int tries = 0;
  Recommendations? _recommendations;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
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
              return await MusicSuggestions.getMusic(query);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text('${suggestion.title} - ${suggestion.artistCredit.first.artistName}'),
              );
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                selectedItem = suggestion;
                tries = 0;
              });
            }),
        ElevatedButton.icon(
          onPressed: selectedItem == null && !isSearching
              ? () {}
              : () async {
                  var resp = await MusicSuggestions.submitRequest(selectedItem!);
                  setState(() {
                    isSearching = true;
                    _recommendations = null;
                  });
                  bool found = false;
                  if (resp == 200) {
                    while (found == false && selectedItem != null) {
                      await Future.delayed(const Duration(milliseconds: 3000), () async {
                        var recommendations = await MusicSuggestions.checkResponse(selectedItem!.id);
                        if (recommendations != null) {
                          found = true;
                          setState(() {
                            _recommendations = recommendations;
                            debugPrint(_recommendations?.albums[0].albumDescription);
                            isSearching = false;
                          });
                        } else {
                          setState(() {
                            tries = tries + 1;
                          });
                        }
                      });
                    }
                  }
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
        Recommended(
          recommendations: _recommendations,
        ),
      ],
    );
  }
}
