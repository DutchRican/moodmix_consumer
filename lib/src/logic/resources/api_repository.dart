import 'package:mood_mix/src/logic/models/music_brainz.dart';
import 'package:mood_mix/src/logic/models/recommendations.dart';
import 'package:mood_mix/src/logic/resources/api_recommendations.dart';
import 'package:mood_mix/src/logic/resources/api_suggestions.dart';

class ApiRepository {
  final _apiSuggestions = ApiSuggestions();
  final _apiRecommendations = ApiRecommendations();

  Future<List<Release>> getMusicSuggestions(String query) {
    return _apiSuggestions.getMusicSuggestions(query);
  }

  Future<Recommendations?> getRecommendations(String releaseId) {
    return _apiRecommendations.checkResponse(releaseId);
  }

  Future<int> requestRecommendations(Release release) {
    return _apiRecommendations.submitRequest(release);
  }
}

class NetworkError extends Error {}
