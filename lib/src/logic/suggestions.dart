import 'dart:convert';
import 'package:flutter/material.dart';

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
    final uri = Uri.parse(
        "https://api-production.patterns.app/api/v1/webhooks/mb0z71aa6kdtsczx0kuh/i51j2xmehqtecdsszyfy/u96wtbceze29os1ilbzi");

    var body =
        Map.from({"artist": release.artistCredit.first.artistName, "album": release.title, "requestId": release.id});
    debugPrint(body.toString());
    var request = await http.post(uri, body: body);
    return request.statusCode;
  }

  static Future<dynamic> checkResponse(String releaseId) async {
    var apikey =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5uY3Bib2d5ZGttZ2RjeGRvemxhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzQ5NTUyNTUsImV4cCI6MTk5MDUzMTI1NX0.FkrlyUWZsFQL2hsnW94df9oRGBzTDNzaDyvYz6dJIUo";
    final uri = Uri.parse(
        "https://nncpbogydkmgdcxdozla.supabase.co/rest/v1/recommendations\?select\=\*\&requestId\=eq.${releaseId}");

    var response = await http.get(uri,
        headers: Map.from({
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/109.0",
          "Accept": "*/*",
          "Accept-Language": "en-US,en;q=0.5",
          "accept-profile": "public",
          "apikey": apikey,
          "x-client-info": "@supabase/auth-helpers-sveltekit@0.8.7",
          "Sec-Fetch-Dest": "empty",
          "Sec-Fetch-Mode": "cors",
          "Sec-Fetch-Site": "cross-site"
        }));

    debugPrint("${response.statusCode} from the supabase check");
    return response.body;
  }
}
