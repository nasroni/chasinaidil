import 'dart:io';

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

    final songList = await HomeController.importService.list("Хазинаи Дил");

    //progressState.value = "Importing songtexts";

    final songListWithText = (await Future.wait(
      songList.map(
        (e) async {
          final text = await rootBundle
              .loadString('assets/chasinaidil/text/${e.songNumber}.txt');
          e.textWChords = text;
          return e;
        },
      ),
    ))
        .toList();

    progressState.value = "Захира, илтимос то 3 дақиқа интизор шавед";

    await HomeController.isar.cleanSongTable();
    await HomeController.isar.saveSongList(songListWithText);

    progressState.value = "Тамом";

    GetStorage().write(Prefs.numDBversion, ReleaseConfig.dbversion);

    //log("duration ${stowa.elapsed}");
  }
}
