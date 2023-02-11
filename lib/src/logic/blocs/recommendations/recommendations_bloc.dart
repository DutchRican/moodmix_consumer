import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/resources/api_repository.dart';
import 'package:mood_mix/src/logic/models/recommendations.dart';
import 'package:mood_mix/src/logic/models/music_brainz.dart';

part 'recommendations_event.dart';
part 'recommendations_state.dart';

const maxTries = 20;

class RecommendationsBloc extends Bloc<RecommendationsEvent, RecommendationsState> {
  late ApiRepository _apiRepository;
  RecommendationsBloc() : super(RecommendationsState(count: 0)) {
    _apiRepository = ApiRepository();

    on<GetRecommendations>((event, emit) async {
      try {
        if (state.count > maxTries) {
          emit(RecommendationsState(hasError: true, message: "Not getting the requested Recommendations back"));
        } else {
          emit(RecommendationsState(count: state.count + 1, recommendations: null, isChecking: true, isLoading: true));
          final recommendations = await _apiRepository.getRecommendations(event.id);
          if (recommendations != null) {
            emit(RecommendationsState(hasLoaded: true, recommendations: recommendations));
            if (recommendations.error != null) {
              emit(RecommendationsState(count: 0, hasError: true, message: recommendations.error));
            }
          } else {
            await Future.delayed(const Duration(seconds: 3));
            add(GetRecommendations(event.id));
          }
        }
      } on NetworkError {
        emit(RecommendationsState(
            count: 0,
            hasError: true,
            message: "Failed to fetch data, is your device online?",
            hasLoaded: false,
            isChecking: false,
            isLoading: false));
      }
    });

    on<RequestRecommendations>((event, _) async {
      await _apiRepository.requestRecommendations(event.release);
      add(GetRecommendations(event.release.id!));
    });
  }
}
