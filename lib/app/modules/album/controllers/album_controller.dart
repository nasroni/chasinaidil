import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  static final IsarService isar = Get.find();

  final Album album = Get.arguments;

  final RxList<Song> songs = List<Song>.empty().obs;

  @override
  void onInit() {
    loadAlbumSongs();
    super.onInit();
  }

  void loadAlbumSongs() async {
    var songsFromDB = await isar.getSongsFromAlbum(album);
    songs.addAll(songsFromDB);
  }
}
