import 'package:isar/isar.dart';

part 'song.g.dart';

@collection
class Song {
  final Id id = Isar.autoIncrement;

  final String title;
  final int? albumId;
  String book;
  final String? psalm;
  final int? duration;
  String textWChords;

  String get songNumber => songNumberInt.toString();
  final int songNumberInt;

  String get lyrics =>
      textWChords.replaceAll(RegExp(r'\[([A-Za-z#0-9]){1,4}\]'), '');

  @ignore
  String get coverAsset =>
      "assets/chasinaidil/covers/cd_${albumId.toString().padLeft(2, "0")}.jpg";
  @ignore
  String get coverAssetHQ =>
      "assets/chasinaidil/covers/cd_hq_${albumId.toString().padLeft(2, "0")}.jpg";

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get titleWords => Isar.splitWords(title);

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get lyricsWords => Isar.splitWords(lyrics);

  Song(
      {required this.songNumberInt,
      required this.title,
      this.albumId,
      this.book = "Гуногун",
      required this.psalm,
      required this.duration,
      this.textWChords = ""});

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
      songNumberInt: int.parse(parsedJson['id']),
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
