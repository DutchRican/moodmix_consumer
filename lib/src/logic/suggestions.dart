import 'dart:convert';
import 'package:mood_mix/src/logic/api_url.dart';
import 'package:mood_mix/src/logic/recommendations.dart';

import 'api_key.dart';
import 'music.dart';
import 'package:http/http.dart' as http;

class MusicSuggestions {
  static Future<List<Release>> getMusic(String query) async {
    if (query.length < 2) return [];
    var resp =
        await http.get(Uri.parse("https://musicbrainz.org/ws/2/release?query=${Uri.encodeComponent(query)}&fmt=json"));
    var items = Music.fromJson(jsonDecode(resp.body));
    return items.releases.toList();
  }

  static Future<int> submitRequest(Release release) async {
    final uri = Uri.parse(apiUrl);

    var body =
        Map.from({"artist": release.artistCredit.first.artistName, "album": release.title, "requestId": release.id});
    var request = await http.post(uri, body: body);
    return request.statusCode;
  }

  static Future<Recommendations?> checkResponse(String releaseId) async {
    final uri = Uri.parse(
        "https://nncpbogydkmgdcxdozla.supabase.co/rest/v1/recommendations\?select=*&requestId=eq.${releaseId}");

    var response = await http.get(uri,
        headers: Map.from({
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/109.0",
          "Accept": "*/*",
          "Accept-Language": "en-US,en;q=0.5",
          "accept-profile": "public",
          "apikey": apikey,
          "authorization": "Bearer $apikey",
          "x-client-info": "@supabase/auth-helpers-sveltekit@0.8.7",
          "Sec-Fetch-Dest": "empty",
          "Sec-Fetch-Mode": "cors",
          "Sec-Fetch-Site": "cross-site"
        }));
    var json = jsonDecode(response.body) as List<dynamic>;
    if (json.isNotEmpty) {
      var suggestions = Recommendations.fromJson(json[0]['recommendations']);
      return suggestions;
    }
    return null;
  }
}
