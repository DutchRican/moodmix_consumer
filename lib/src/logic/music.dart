class ArtistCredit {
  late String name;
  late String artistName;

  ArtistCredit({required this.name, required this.artistName});

  ArtistCredit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    artistName = json['artist']?['name'];
  }
}

class Release {
  late String id;
  late int score;
  late String title;
  late String status;
  late List<ArtistCredit> artistCredit;

  Release(
      {required this.id, required this.score, required this.title, required this.status, required this.artistCredit});

  Release.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    score = json['score'] as int;
    title = json['title'] ?? 'empty';
    status = json['status'] ?? 'emtpy';
    artistCredit = (json['artist-credit'] as List).map((item) => ArtistCredit.fromJson(item)).toList();
  }
}

class Music {
  late List<Release> releases;

  Music({required this.releases});

  Music.fromJson(Map<String, dynamic> data) {
    releases = (data['releases'] as List).map((item) => Release.fromJson(item)).toList();
  }
}
