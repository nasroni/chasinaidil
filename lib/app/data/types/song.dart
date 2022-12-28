import 'package:isar/isar.dart';

part 'song.g.dart';

@collection
class Song {
  final Id id;
  final String title;
  final int? albumId;
  String book;
  final String? psalm;
  final int? duration;
  String text;

  String get songNumber => id.toString();

  Song(
      {required this.id,
      required this.title,
      this.albumId,
      this.book = "Гуногун",
      required this.psalm,
      required this.duration,
      this.text = ""});

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
      id: int.parse(parsedJson['id']),
      title: parsedJson['title'],
      albumId:
          parsedJson['album'] == "-" ? null : int.parse(parsedJson['album']),
      psalm: parsedJson['psalm'] == "false" ? null : parsedJson['psalm'],
      duration: parsedJson['duration'] is String
          ? null
          : (parsedJson['duration'] * 1000).round(),
    );
  }
}
