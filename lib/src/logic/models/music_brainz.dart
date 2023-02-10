class ArtistCredit {
  String? name;
  String? artistName;

  ArtistCredit({name, artistName});

  ArtistCredit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    artistName = json['artist']?['name'];
  }
}

class Release {
  String? id;
  int? score;
  String? title;
  String? status;
  List<ArtistCredit>? artistCredit;
  String? error;

  Release({id, score, title, status, artistCredit});

  Release.withError(String errorMessage) {
    error = errorMessage;
  }
  Release.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    score = json['score'] as int;
    title = json['title'] ?? 'empty';
    status = json['status'] ?? 'emtpy';
    artistCredit = (json['artist-credit'] as List).map((item) => ArtistCredit.fromJson(item)).toList();
  }
}

class Music {
  List<Release>? releases;

  Music({releases});

  Music.fromJson(Map<String, dynamic> data) {
    releases = (data['releases'] as List).map((item) => Release.fromJson(item)).toList();
  }
}
