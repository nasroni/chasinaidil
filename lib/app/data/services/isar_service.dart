import 'dart:io';

import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/playlist.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;
  late Isar dbSync;
  late Directory dir;

  IsarService() {
    db = openDB();
    dbSyncReady();
  }
  void dbSyncReady() async {
    dbSync = await db;
  }

  Future<void> savePlaylist(Playlist playlist) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.playlists.putSync(playlist));
    Get.find<AppController>().update(['updateViews']);
  }

  Future<List<Playlist>> getAllPlaylists() async {
    final isar = await db;
    return isar.playlists.where().findAll();
  }

  Playlist getFavoriteList() {
    final isar = dbSync;
    var playlist = isar.playlists.where().idEqualTo(0).findFirstSync();
    return playlist!;
  }

  Future<void> deletePlaylist(Playlist playlist) async {
    final isar = await db;
    isar.writeTxnSync<void>(() => isar.playlists.deleteSync(playlist.id));
    Get.find<AppController>().update(['updateViews']);
  }

  Future<void> saveSong(Song newSong) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.songs.putSync(newSong));
  }

  Future saveSongList(List<Song> songList) async {
    final isar = await db;

    //final isar = await Isar.open([SongSchema], name: 'default');

    isar.writeTxnSync(() async {
      for (var song in songList) {
        isar.songs.putSync(song);
      }
    });
    /*Map map = {};
    map['dir'] = dir;
    map['songList'] = songList;
    await compute(externalSaveSongList, map);*/
  }

  Future<Song?> getSongById(int id) async {
    final isar = await db;
    return await isar.songs.where().idEqualTo(id).findFirst();
  }

  Song? getSongByIdSync(int id) {
    final isar = dbSync;
    var songs = isar.songs.where().idEqualTo(id).findFirstSync();
    return songs;
  }

  Future<Song?> getSongByTitle(String title) async {
    final isar = await db;
    return await isar.songs.where().filter().titleContains(title).findFirst();
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

  Future<List<Song>> getAllSongsFromSongBook(String songbook) async {
    final isar = await db;
    return await isar.songs.filter().bookEqualTo(songbook).findAll();
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
      dir = await getApplicationDocumentsDirectory();

      return await Isar.open(
        [SongSchema, PlaylistSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<List<Song>> getOneSongPerAlbum() async {
    final isar = await db;
    return isar.songs.where().distinctByAlbumId().distinctByBookId().findAll();
  }
}

Future externalSaveSongList(Map map) async {
  Directory dir = map['dir'];
  List<Song> songList = map['songList'];
  final isar = await Isar.open(
    [SongSchema, PlaylistSchema],
    name: 'default',
    directory: dir.path,
  );

  isar.writeTxnSync(() async {
    for (var song in songList) {
      isar.songs.putSync(song);
    }
  });
}
