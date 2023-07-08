import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

part 'song.g.dart';

@collection
class Song {
  Id get id => (bookId * 1000) + songNumberInt;

  final String title;
  final int? albumId;
  String book;
  String bookCyr;
  final String? psalm;
  final int? duration;
  String textWChords;
  final DateTime? newRecording;
  final bool hasKaraoke;
  final bool hasRecording;
  final String? md5hash;

  String get songNumber => songNumberInt.toString();
  final int songNumberInt;

  int get bookId {
    return bookIdForString(book);
  }

  String get bookTitleEn {
    switch (bookId) {
      case 1:
        return "chasinaidil";
      case 2:
        return "chashma";
      default:
        return "digaron";
    }
  }

  static bookIdForString(bookString) {
    switch (bookString) {
      case "chasinaidil":
        return 1;
      case "chashma":
        return 2;
      default:
        return 9;
    }
    /*switch (bookString) {
      case "Хазинаи Дил":
        return 1;
      case "Чашма":
        return 2;
      default:
        return 9;
    }*/
  }

  bool get isFavorite {
    IsarService isar = Get.find();
    var favorite = isar.getFavoriteList();
    return favorite.songIds.contains(id);
  }

  String get lyrics => textWChords.replaceAll(
      RegExp(r'\[([A-Hbmsu#0-9]){1,5}(\/[A-H][b#]?)?\]'), '');

  @ignore
  DateTime? get downloaded {
    var savedDate = GetStorage().read(id.toString()) ?? '';
    return DateTime.tryParse(savedDate);
  }

  @ignore
  bool get isDownloaded {
    if (downloaded == null) return false;
    if (newRecording == null) return true;
    return downloaded!.isAfter(newRecording!);
  }

  @ignore
  String get coverAsset =>
      "assets/$book/covers/cd_${albumId.toString().padLeft(2, "0")}.jpg";
  @ignore
  String get coverAssetHQ =>
      "assets/$book/covers/cd_${albumId.toString().padLeft(2, "0")}_hq.jpg";

  @ignore
  Future<String> get coverFileHQ async {
    String folder = (await getApplicationDocumentsDirectory()).path;
    return "$folder/$book/${albumId.toString().padLeft(2, "0")}_hq.jpg";
  }

  @ignore
  String get sheetPath => "assets/$book/sheet/$songNumber.pdf";

  @ignore
  String get audioPathOnline {
    if (book == "chasinaidil") {
      return "https://chasinaidil.nasroni.one/mp3/all/$songNumber.mp3";
    } else {
      return "https://chasinaidil.nasroni.one/mp3/$book/$songNumber.mp3";
    }
  }

  @ignore
  Future<String> get audioPathLocal async {
    String folder = (await getApplicationDocumentsDirectory()).path;
    return "$folder/$book/$songNumber.mp3";
  }

  /*@ignore
  Future<Audio> get audio async => Audio.file(
        await audioPathLocal,
        metas: Metas(
          artist: book,
          //artist: "isoimaseh.com",
          title: "$songNumber. $title",
          image: MetasImage.asset(coverAssetHQ),
          id: songNumber,
        ),
      );*/
  @ignore
  Future<ProgressiveAudioSource> get audio async {
    MediaItem mediaItem = MediaItem(
      id: id.toString(),
      title: "$songNumber. $title",
      album: bookCyr,
      artist: bookCyr,
      artUri: Uri.file(await coverFileHQ),
    );

    return ProgressiveAudioSource(
      Uri.file(await audioPathLocal),
      tag: mediaItem,
    );
  }

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get titleWords {
    return Isar.splitWords('$title ${AppController.transcribe(title)}');
  }

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get lyricsWords => Isar.splitWords(lyrics);

  Song(
      {required this.songNumberInt,
      required this.title,
      this.albumId,
      this.book = "Гуногун",
      this.bookCyr = "Гуногун",
      this.psalm,
      this.duration,
      this.textWChords = "",
      this.newRecording,
      this.hasKaraoke = false,
      this.hasRecording = true,
      this.md5hash});

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
      newRecording: DateTime.tryParse(parsedJson['newRecording'] ?? ""),
      hasRecording: (parsedJson['recorded'] == "no") ? false : true,
      md5hash: parsedJson['recorded'],
    );
  }
}
