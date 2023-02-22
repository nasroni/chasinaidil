import 'dart:developer';

import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  static final IsarService isar = Get.find();

  final Album album = Get.arguments;

  final RxList<Song> songs = List<Song>.empty().obs;

  final RxBool isTitleEditing = false.obs;

  @override
  void onInit() {
    loadAlbumSongs();
    super.onInit();
  }

  void loadAlbumSongs() async {
    var songsFromDB = await isar.getSongsFromAlbum(album);
    songs.addAll(songsFromDB);
  }

  void setNewName(String value) {
    album.playlist?.setName(value);
    isTitleEditing.value = false;

    if (album.playlist != null) isar.savePlaylist(album.playlist!);

    Get.find<AppController>().update(['playlistUpdate']);
    if (album.albumId == 999999999999999999) Get.back();
  }

  void setNewColor() {
    album.playlist?.newColor();

    if (album.playlist != null) isar.savePlaylist(album.playlist!);

    Get.find<AppController>().update(['playlistUpdate']);
  }

  void deletePlaylist() {
    isar.deletePlaylist(album.playlist!);
    Get.find<AppController>().update(['deletedPlaylist']);
    Get.back();
  }
}
