import 'dart:io';

import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/playlist.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:chasinaidil/release_config.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoadingController extends GetxController {
  RxString progressState = "Интизор шавед ...".obs;

  Future<void> import() async {
    //final stowa = Stopwatch()..start();
    // chasinaidil import
    //progressState.value = "loading started";

    final IsarService isar = Get.find();
    var playlists = await isar.getAllPlaylists();
    var favorite =
        playlists.firstWhereOrNull((element) => element.id == 0) ?? Playlist()
          ..id = 0;
    favorite.name = 'Дӯстдошта';
    favorite.setColor('FF0000');

    isar.savePlaylist(favorite);

    // Prepare song import
    await HomeController.isar.cleanSongTable();

    // CHASINAI DIL IMPORT
    await importBook("Хазинаи Дил", "chasinaidil");
    await importBook("Чашма", "tshashma");

    // tshashma IMPORT

    // copy album images to disk
    List<Song> songs = await HomeController.isar.getOneSongPerAlbum();
    for (var song in songs) {
      ByteData data = await rootBundle.load(song.coverAssetHQ);
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      String targetPath = await song.coverFileHQ;
      Directory(targetPath.substring(0, targetPath.lastIndexOf('/')))
          .createSync(recursive: true);
      await File(await song.coverFileHQ).writeAsBytes(bytes);
    }

    progressState.value = "Тамом";

    GetStorage().write(Prefs.numDBversion, ReleaseConfig.dbversion);

    //log("duration ${stowa.elapsed}");
  }

  Future<void> importBook(bookString, bookStringEn) async {
    final songList =
        await HomeController.importService.list(bookString, bookStringEn);

    final songListWithText = (await Future.wait(
      songList.map(
        (e) async {
          final fileUrl = 'assets/$bookStringEn/text/${e.songNumber}.txt';
          if (File(fileUrl).existsSync()) {
            final text = await rootBundle.loadString(fileUrl);
            e.textWChords = text;
          } else {
            e.textWChords = "";
          }

          return e;
        },
      ),
    ))
        .toList();

    progressState.value =
        "Захира, илтимос то 3 дақиқа интизор шавед\n$bookString";
    await HomeController.isar.saveSongList(songListWithText);
  }
}
