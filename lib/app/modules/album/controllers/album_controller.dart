import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  AlbumController();
  AlbumController.withAlbum(this.album);

  static final IsarService isar = Get.find();

  late Album album = Get.arguments;

  final RxList<Song> songs = List<Song>.empty().obs;

  bool get isEverythingDownloaded {
    List<Song> songList = songs.toList(growable: true);
    songList.removeWhere((Song song) => song.hasRecording == false);
    return songList.indexWhere((Song song) => !song.isDownloaded) == -1;
  }

  bool get isNothingDownloaded {
    return songs.indexWhere((Song song) => song.isDownloaded) == -1;
  }

  RxBool isFirstDownload = false.obs;

  final RxBool isTitleEditing = false.obs;

  @override
  void onInit() {
    loadAlbumSongs();
    //Get.find<AppController>().update(['updateViews']);
    super.onInit();
  }

  void loadAlbumSongs() async {
    List<Song> songsFromDB;
    if (album.playlist != null) {
      songsFromDB = await album.playlist!.giveSongList();
    } else {
      if (album.albumId == 17 && album.songBook == SongBook.chasinaidil) {
        songsFromDB = await isar.getAllSongsFromSongBook(
            HomeController.giveBookTitle(album.songBook));
      } else {
        songsFromDB = await isar.getSongsFromAlbum(album);
      }
    }
    songs.addAll(songsFromDB);
    Get.find<AppController>().update(['updateViews']);
  }

  void setNewName(String value) {
    album.playlist?.setName(value);
    isTitleEditing.value = false;

    if (album.playlist != null) isar.savePlaylist(album.playlist!);

    if (album.albumId == 999999999999999999) Get.back(result: album.playlist);
  }

  void setNewColor() {
    album.playlist?.newColor();

    if (album.playlist != null) isar.savePlaylist(album.playlist!);
  }

  void deletePlaylist() {
    isar.deletePlaylist(album.playlist!);

    Get.back();
  }
}
