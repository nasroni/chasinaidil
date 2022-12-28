import 'dart:developer';

import 'package:chasinaidil/app/data/types/song.dart';
import 'package:isar/isar.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveSong(Song newSong) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.songs.putSync(newSong));
  }

  Future<void> saveSongList(List<Song> songList) async {
    final isar = await db;
    isar.writeTxnSync(() {
      for (var song in songList) {
        isar.songs.putSync(song);
      }
    });
  }

  Future<Song?> getSongById(int id) async {
    final isar = await db;
    return await isar.songs.where().idEqualTo(id).findFirst();
  }

  Future<List<Song>> getAllSongs() async {
    final isar = await db;
    return await isar.songs.where().findAll();
  }

  Future<List<Song>> getSearchResults(String searchQuery) async {
    final isar = await db;
    log("hallo");
    return await isar.songs
        .filter()
        .songNumberStartsWith(searchQuery)
        .findAll();
  }

  // TODO: löschen wenn fertig programmiert
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [SongSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
