import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/models/music_brainz.dart';
import 'package:mood_mix/src/logic/resources/api_repository.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  late ApiRepository _apiRepository;
  SuggestionsBloc() : super(SuggestionsInitial()) {
    _apiRepository = ApiRepository();

    on<GetSuggestionsList>((event, emit) async {
      try {
        emit(SuggestionsLoading());
        final suggestions = await _apiRepository.getMusicSuggestions("");
        emit(SuggestionsLoaded(suggestions));
        if (suggestions.isNotEmpty && suggestions.first.error != null) {
          emit(SuggestionsError(suggestions.first.error));
        }
      } on NetworkError {
        emit(const SuggestionsError("Failed to fetch data, is the device online?"));
      }
    });
  }
}
