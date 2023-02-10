import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_mix/src/logic/resources/api_repository.dart';
import 'package:mood_mix/src/logic/models/recommendations.dart';
import 'package:mood_mix/src/logic/models/music_brainz.dart';

part 'recommendations_event.dart';
part 'recommendations_state.dart';

class RecommendationsBloc extends Bloc<RecommendationsEvent, RecommendationsState> {
  late ApiRepository _apiRepository;
  RecommendationsBloc() : super(RecommendationsInitial()) {
    _apiRepository = ApiRepository();

    on<GetRecommendations>((event, emit) async {
      try {
        emit(RecommendationsLoading());
        final recommendations = await _apiRepository.getRecommendations("");
        if (recommendations != null) {
          emit(RecommendationsLoaded(recommendations));
          if (recommendations.error != null) {
            emit(RecommendationsError(recommendations.error));
          }
        }
      } on NetworkError {
        emit(const RecommendationsError("Failed to fetch data, is your device online?"));
      }
    });

    on<RequestRecommendations>((event, _) {
      _apiRepository.requestRecommendations(event.release);
    });
  }
}
