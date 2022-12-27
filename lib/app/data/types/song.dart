import 'package:isar/isar.dart';

//part 'song.g.dart';

@collection
class Song {
  final int id;
  final String title;
  final String albumId;
  final bool psalm;
  final String duration;
  final String text;

  int get durationInt {
    return (double.parse(duration) * 1000).round();
  }

  Song(
      {required String id,
      required this.title,
      required this.albumId,
      required this.psalm,
      required this.duration,
      this.text = ""})
      : id = int.parse(id);

  factory Song.fromJson(Map<String, dynamic> parsedJson) {
    return Song(
        id: parsedJson['id'],
        title: parsedJson['title'],
        albumId: parsedJson['album'].toString(),
        psalm: (parsedJson['psalm'] == "true" ? true : false),
        duration: parsedJson['duration'].toString());
  }
}
