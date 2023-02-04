import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mood_mix/src/logic/suggestions.dart';
import 'package:mood_mix/src/logic/music.dart';
import 'package:mood_mix/src/screens/results.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Release? selectedItem;
  int tries = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        children: [
          TypeAheadField(
              textFieldConfiguration: const TextFieldConfiguration(
                  // autofocus: true,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
              )),
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
          ElevatedButton(
            onPressed: selectedItem == null
                ? () {}
                : () async {
                    var resp = await MusicSuggestions.submitRequest(selectedItem!);
                    bool found = false;
                    if (resp == 200) {
                      debugPrint("$found ${found == false}");
                      while (found == false && selectedItem != null) {
                        await Future.delayed(const Duration(milliseconds: 3000), () async {
                          var res = await MusicSuggestions.checkResponse(selectedItem!.id);
                          debugPrint("${res.toString()} ${selectedItem?.id}");
                          if (res.length > 2) {
                            found = true;
                          } else {
                            setState(() {
                              tries = tries + 1;
                            });
                          }
                        });
                      }
                    }
                  },
            child: selectedItem == null
                ? const Text(
                    "Select an Album",
                    style: TextStyle(color: Colors.grey),
                  )
                : const Text("Submit"),
          ),
          const Results(),
          Text(tries > 0 ? "Tries: $tries" : ""),
        ],
      ),
    );
  }
}
