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
  String textWChords;

  String get songNumber => id.toString();
  int get songNumberInt => id;

  String get lyrics =>
      textWChords.replaceAll(RegExp(r'\[([A-Za-z]){1,2}\]'), '');

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get titleWords => Isar.splitWords(title);

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get lyricsWords => Isar.splitWords(lyrics);

  Song(
      {required this.id,
      required this.title,
      this.albumId,
      this.book = "Гуногун",
      required this.psalm,
      required this.duration,
      this.textWChords = ""});

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
