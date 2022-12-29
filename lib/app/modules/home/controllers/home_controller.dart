import 'package:chasinaidil/app/data/services/import_service.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:flutter/cupertino.dart';
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

  final RxList<Song> titelSearchResults = RxList<Song>([]);
  final RxList<Song> lyricsSearchResults = RxList<Song>([]);

  late final Worker searchWorker;

  final TextEditingController searchEditingController = TextEditingController();

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
  void closeSearch() {
    isSearchActive.value = false;
    searchEditingController.clear();
    titelSearchResults.clear();
  }

  void doSearch() async {
    if (searchValue.value.isEmpty) {
      titelSearchResults.clear();
    } else {
      titelSearchResults.value =
          await isar.getTitleSearchResults(searchValue.value);
    }
  }

  void import() async {
    //final stowa = Stopwatch()..start();
    // chasinaidil import
    final songList = await importService.list("Хазинаи Дил");
    final songListWithText = (await Future.wait(
      songList.map(
        (e) async {
          final text = await rootBundle
              .loadString('assets/chasinaidil/text/${e.id}.txt');
          e.textWChords = text;
          return e;
        },
      ),
    ))
        .toList();
    isar.saveSongList(songListWithText);
    isDBfilled.value = true;

    //log("duration ${stowa.elapsed}");
  }
}
