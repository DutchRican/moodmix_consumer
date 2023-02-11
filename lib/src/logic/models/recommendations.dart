import 'package:flutter/material.dart';

class Films {
  late String? film;
  late String? director;
  late String? filmDescription;

  Films({required this.film, required this.director, required this.filmDescription});
  Films.fromJson(Map<String, dynamic> json) {
    film = json['film'];
    director = json['director'];
    filmDescription = json['film_description'];
  }
}

class Albums {
  late String? album;
  late String? artist;
  late String? albumDescription;

  Albums({required this.album, required this.artist, required this.albumDescription});
  Albums.fromJson(Map<String, dynamic> json) {
    album = json['album'];
    artist = json['artist'];
    albumDescription = json['album_description'];
  }
}

class Series {
  late String? series;
  late String? creators;
  late String? seriesDescription;

  Series({required this.series, required this.creators, required this.seriesDescription});
  Series.fromJson(Map<String, dynamic> json) {
    series = json['series'];
    creators = json['creators'];
    seriesDescription = json['series_description'];
  }
}

class RequestedAlbum {
  late String album;
  late String artist;
  late String information;

  RequestedAlbum({required this.album, required this.artist, required this.information});

  RequestedAlbum.fromJson(Map<String, dynamic> json) {
    album = json['album'];
    artist = json['artist'];
    bool isBadArtist = artist == 'Error parsing request';
    bool isBadAlbum = album == 'Error parsing request';
    List<String> test = [];
    if (!isBadAlbum) {
      test.add(album);
    }
    if (!isBadArtist) {
      test.add(artist);
    }
    information = test.join(' - ');
  }
}

class Recommendations {
  String? mood;
  List<Films>? films;
  List<Albums>? albums;
  List<Series>? series;
  RequestedAlbum? requestedAlbum;
  String? error;

  Recommendations(
      {required this.mood,
      required this.films,
      required this.albums,
      required this.series,
      required this.requestedAlbum});

  Recommendations.withError(String errorMessage) {
    error = errorMessage;
  }

  Recommendations.fromJson(Map<String, dynamic> json) {
    mood = json['mood'];
    if (json['films'] != null) {
      films = <Films>[];
      json['films'].forEach((v) {
        films?.add(Films.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albums = <Albums>[];
      json['albums'].forEach((v) {
        albums?.add(Albums.fromJson(v));
      });
    }
    if (json['series'] != null) {
      series = <Series>[];
      json['series'].forEach((v) {
        series?.add(Series.fromJson(v));
      });
    }
    if (json['requestedAlbum'] != null) {
      requestedAlbum = RequestedAlbum.fromJson(json['requestedAlbum'].first);
    }
  }
}
