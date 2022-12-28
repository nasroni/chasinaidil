import 'package:isar/isar.dart';

part 'song.g.dart';

@collection
class Song {
  final Id id;
  final String title;
  final String albumId;
  final bool psalm;
  final int? duration;
  final String text;

  Song(
      {required this.id,
      required this.title,
      required this.albumId,
      required this.psalm,
      required this.duration,
      this.text = ""});

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
      id: parsedJson['id'],
      title: parsedJson['title'],
      albumId: parsedJson['album'].toString(),
      psalm: (parsedJson['psalm'] == "true" ? true : false),
      duration: (double.parse(parsedJson['duration']) * 1000).round(),
    );
  }
}
