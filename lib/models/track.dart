class Track {
  final String id;
  final String name;
  final String artistName;
  final String albumName;
  final String duration;
  final String imageUrl;
  final String audioUrl;
  final List<String> tags;

  Track({
    required this.id,
    required this.name,
    required this.artistName,
    required this.albumName,
    required this.duration,
    required this.imageUrl,
    required this.audioUrl,
    required this.tags,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      artistName: json['artist_name'] ?? '',
      albumName: json['album_name'] ?? '',
      duration: json['duration'] ?? '',
      imageUrl: json['image'] ?? '',
      audioUrl: json['audio'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist_name': artistName,
      'album_name': albumName,
      'duration': duration,
      'image': imageUrl,
      'audio': audioUrl,
      'tags': tags,
    };
  }
}
