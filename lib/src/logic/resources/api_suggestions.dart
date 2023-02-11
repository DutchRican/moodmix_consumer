import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mood_mix/src/logic/models/music_brainz.dart';

class ApiSuggestions {
  Future<List<Release>> getMusicSuggestions(String query) async {
    if (query.length < 2) return [];
    try {
      var resp = await http
          .get(Uri.parse("https://musicbrainz.org/ws/2/release?query=${Uri.encodeComponent(query)}&fmt=json"));
      var items = Music.fromJson(jsonDecode(resp.body));
      return items.releases?.toList() ?? [];
    } catch (error) {
      debugPrint("Error: $error");
      return [Release.withError('Data issue / Connection issue')];
    }
  }
}
