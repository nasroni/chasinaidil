import 'dart:developer';

import 'package:chasinaidil/app/data/services/import_service.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/types/song.dart';

class HomeController extends GetxController {
  final RxInt count = 0.obs;
  final RxBool isSearchActive = false.obs;
  final RxBool isDBfilled = false.obs;

  final RxString searchValue = "".obs;

  final IsarService isar = Get.find();
  final ImportService importService = ImportService();

  final RxList<Song> searchResults = RxList<Song>([]);

  late final Worker searchWorker;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    searchWorker = ever(searchValue, (_) => doSearch());
  }

  @override
  void onClose() {
    super.onClose();
    searchWorker.dispose();
  }

  void increment() => count.value++;

  void openSearch() => isSearchActive.value = true;
  void closeSearch() => isSearchActive.value = false;

  void doSearch() async {
    searchResults.value = await isar.getSearchResults(searchValue.value);
  }

  void import() async {
    //final stopwa = Stopwatch()..start();
    // chasinaidil import
    final songList = await importService.list("Хазинаи Дил");
    final songListWithText = (await Future.wait(
      songList.map(
        (e) async {
          final text = await rootBundle
              .loadString('assets/chasinaidil/text/${e.id}.txt');
          e.text = text;
          return e;
        },
      ),
    ))
        .toList();
    isar.saveSongList(songListWithText);
    isDBfilled.value = true;

    //log("duration ${stopwa.elapsed}");
  }
}
