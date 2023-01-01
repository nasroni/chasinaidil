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

  final RxList<Song> searchResults = RxList<Song>([]);
  final RxInt searchResultLyricsBeginPosition = 0.obs;

  late final Worker searchWorker;

  final TextEditingController searchEditingController = TextEditingController();

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
    searchResults.clear();
  }

  void doSearch() async {
    // only numeric search
    if (searchValue.value.isEmpty) {
      searchResults.clear();
    } else {
      // Search song number and title
      final titleSearchResults =
          await isar.getTitleSearchResults(searchValue.value);

      if (int.tryParse(searchValue.value) == null) {
        // Search lyrics and remove duplicates
        final lyricsSearchResults = (await isar
            .getLyricsSearchResults(searchValue.value))
          ..removeWhere((lyricsElement) => titleSearchResults.any(
              (titleElement) =>
                  lyricsElement.songNumberInt == titleElement.songNumberInt));

        // Create info that now lyrics results start
        searchResultLyricsBeginPosition.value = titleSearchResults.length;
        final combinedSearchResults = titleSearchResults;

        // combine the two lists
        combinedSearchResults.insertAll(
            combinedSearchResults.length, lyricsSearchResults);
        searchResults.value = combinedSearchResults;
      } else {
        // if only numeric results, lyric search and divider not in use
        searchResultLyricsBeginPosition.value = 999999;
        searchResults.value = titleSearchResults;
      }
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
              .loadString('assets/chasinaidil/text/${e.songNumber}.txt');
          e.textWChords = text;
          return e;
        },
      ),
    ))
        .toList();
    await isar.cleanDb();
    await isar.saveSongList(songListWithText);
    isDBfilled.value = true;

    //log("duration ${stowa.elapsed}");
  }
}
