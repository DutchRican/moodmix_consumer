import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mood_mix/src/logic/blocs/recommendations/recommendations_bloc.dart';
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
  final TextEditingController _typeAheadController = TextEditingController();
  Release? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(builder: (context, state) {
      String? information = state.recommendations?.requestedAlbum?.information;
      return Column(
        children: [
          TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: _typeAheadController,
                  // autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Album, Artist or Song",
                    border: OutlineInputBorder(),
                  )),
              // hideOnEmpty: true,
              // hideOnLoading: true,
              keepSuggestionsOnLoading: false,
              suggestionsCallback: (query) async {
                return await _apiRepository.getMusicSuggestions(query);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(getTitle(suggestion)),
                );
              },
              onSuggestionSelected: (suggestion) {
                _typeAheadController.text = getTitle(suggestion);
                BlocProvider.of<RecommendationsBloc>(context).add(ClearRecommendations());
                setState(() {
                  selectedItem = suggestion;
                });
              }),
          ElevatedButton(
            onPressed: selectedItem == null || state.isChecking
                ? () {}
                : () {
                    BlocProvider.of<RecommendationsBloc>(context).add(RequestRecommendations(selectedItem!));
                    _typeAheadController.clear();
                  },
            child: selectedItem == null
                ? const Text(
                    "Select an Album",
                    style: TextStyle(color: Colors.grey),
                  )
                : state.isChecking
                    ? const Text("Getting information")
                    : const Text("Submit"),
          ),
          !state.isChecking && state.recommendations != null
              ? Container(
                  alignment: Alignment.topLeft,
                  child: information != null && information.isNotEmpty
                      ? Text('Showing results for ${state.recommendations?.requestedAlbum?.information}')
                      : Text(
                          'Something went wrong fetching album information',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                )
              : Text(state.count > 0 && state.isChecking ? "Tries: ${state.count}" : ""),
          const Recommended(),
        ],
      );
    });
  }

  String getTitle(Release? release) {
    if (release == null) return '';
    return '${release.title} - ${release.artistCredit?.first.artistName}';
  }
}
