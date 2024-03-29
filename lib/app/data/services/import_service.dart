import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../types/song.dart';

class ImportService {
  ImportService() {
    _jsonCacheChasinaidil = readSongDataFileChasinaidil();
    _jsonCachechashma = readSongDataFilechashma();
    // _jsonCacheDigaron = readSongDataFileDigaron(); // TODO before
  }

  static Future<String> readSongDataFileChasinaidil() async {
    return await rootBundle.loadString('assets/chasinaidil/songs.json');
  }

  static Future<String> readSongDataFilechashma() async {
    return await rootBundle.loadString('assets/chashma/songs.json');
  }

  static Future<String> readSongDataFileDigaron() async {
    return await rootBundle.loadString('assets/digaron/songs.json');
  }

  static late Future<String> _jsonCacheChasinaidil;
  static late Future<String> _jsonCachechashma;
  static late Future<String> _jsonCacheDigaron;

  Future<List<Song>> list(String bookName, String bookNameEn) async {
    String jsonString;

    if (bookNameEn == "chasinaidil") {
      jsonString = await _jsonCacheChasinaidil;
    } else if (bookNameEn == "chashma") {
      jsonString = await _jsonCachechashma;
    } else {
      jsonString = await _jsonCacheDigaron;
    }

    final jsonResponse = json.decode(jsonString);

    var list = jsonResponse as List;
    List<Song> songList = list
        .map((i) => Song.fromJson(i)
          ..book = bookNameEn
          ..bookCyr = bookName)
        .toList();

    return songList;
  }
}
