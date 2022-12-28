import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../types/song.dart';

class ImportService {
  ImportService() {
    _jsonCache = readSongDataFile();
  }

  static Future<String> readSongDataFile() async {
    return await rootBundle.loadString('assets/chasinaidil/songs.json');
  }

  static late Future<String> _jsonCache;

  Future<List<Song>> list(String bookName) async {
    String jsonString = await _jsonCache;
    final jsonResponse = json.decode(jsonString);

    var list = jsonResponse as List;
    List<Song> songList =
        list.map((i) => Song.fromJson(i)..book = bookName).toList();

    return songList;
  }
}
