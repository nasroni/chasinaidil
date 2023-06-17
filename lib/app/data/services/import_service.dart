import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../types/song.dart';

class ImportService {
  ImportService() {
    _jsonCacheChasinaidil = readSongDataFileChasinaidil();
    _jsonCachetshashma = readSongDataFiletshashma();
    // _jsonCacheDigaron = readSongDataFileDigaron(); // TODO before
  }

  static Future<String> readSongDataFileChasinaidil() async {
    return await rootBundle.loadString('assets/chasinaidil/songs.json');
  }

  static Future<String> readSongDataFiletshashma() async {
    return await rootBundle.loadString('assets/tshashma/songs.json');
  }

  static Future<String> readSongDataFileDigaron() async {
    return await rootBundle.loadString('assets/digaron/songs.json');
  }

  static late Future<String> _jsonCacheChasinaidil;
  static late Future<String> _jsonCachetshashma;
  static late Future<String> _jsonCacheDigaron;

  Future<List<Song>> list(String bookName, String bookNameEn) async {
    String jsonString;

    if (bookNameEn == "chasinaidil") {
      jsonString = await _jsonCacheChasinaidil;
    } else if (bookNameEn == "tshashma") {
      jsonString = await _jsonCachetshashma;
    } else {
      jsonString = await _jsonCacheDigaron;
    }

    final jsonResponse = json.decode(jsonString);

    var list = jsonResponse as List;
    List<Song> songList =
        list.map((i) => Song.fromJson(i)..book = bookNameEn).toList();

    return songList;
  }
}
