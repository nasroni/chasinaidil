import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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

  Future saveSongList(List<Song> songList) async {
    /*final isar = await db;

    //final isar = await Isar.open([SongSchema], name: 'default');

    isar.writeTxnSync(() async {
      for (var song in songList) {
        isar.songs.putSync(song);
      }
    });*/
    await compute(externalSaveSongList, songList);
  }

  Future<Song?> getSongById(int id) async {
    final isar = await db;
    return await isar.songs.where().idEqualTo(id).findFirst();
  }

  Future<List<Song>> getSongsByIds(List<int> ids) async {
    final isar = await db;
    return await isar.songs
        .filter()
        .anyOf(ids, (q, id) => q.idEqualTo(id))
        .findAll();
  }

  Future<List<Song>> getAllSongs() async {
    final isar = await db;
    return await isar.songs.where().findAll();
  }

  Future<List<Song>> getSongsFromAlbum(Album album) async {
    final isar = await db;

    if (album.title == 'Забур') {
      return await isar.songs.filter().psalmIsNotEmpty().findAll();
    } else {
      var albumId = album.albumId;
      return await isar.songs.filter().albumIdEqualTo(albumId).findAll();
    }
  }

  Future<List<Song>> getTitleSearchResults(String searchQuery) async {
    final isar = await db;
    if (int.tryParse(searchQuery) != null) {
      return await isar.songs
          .filter()
          .songNumberStartsWith(searchQuery)
          .findAll();
    } else {
      final searchWords = Isar.splitWords(searchQuery);

      return await isar.songs
          .where()
          .titleWordsElementStartsWith(searchWords[0])
          .filter()
          .optional(
              searchWords.length > 1,
              (q) => q.allOf(
                  searchWords.sublist(1),
                  (q, String word) => q.titleWordsElementStartsWith(word,
                      caseSensitive: false)))
          .findAll();
    }
  }

  Future<List<Song>> getLyricsSearchResults(String searchQuery) async {
    final isar = await db;
    final searchWords = Isar.splitWords(searchQuery);

    return await isar.songs
        .where()
        .lyricsWordsElementStartsWith(searchWords[0])
        .filter()
        .optional(
            searchWords.length > 1,
            (q) => q.allOf(searchWords.sublist(1),
                (q, String word) => q.lyricsWordsElementStartsWith(word)))
        .findAll();
  }

  Future<void> cleanSongTable() async {
    final isar = await db;
    await isar.writeTxn(() => isar.songs.clear());
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

Future externalSaveSongList(dynamic songList) async {
  final isar = await Isar.open([SongSchema], name: 'default');

  isar.writeTxnSync(() async {
    for (var song in songList) {
      isar.songs.putSync(song);
    }
  });
}
