import 'package:chasinaidil/app/data/services/import_service.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:chasinaidil/release_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  final RxBool isShowingLastSearched = true.obs;

  late final Worker searchWorker;

  final TextEditingController searchEditingController = TextEditingController();

  @override
  void onInit() {
    showLastSearchedSongs();
    super.onInit();
  }

  @override
  void onReady() {
    searchWorker = ever(searchValue, (_) => doSearch());
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchWorker.dispose();
  }

  void increment() => count.value++;

  Future<void> openSearch() async {
    isSearchActive.value = true;
    showLastSearchedSongs();
  }

  void closeSearch() {
    isSearchActive.value = false;
    searchEditingController.clear();
    searchResults.clear();
  }

  void showLastSearchedSongs() async {
    final List<dynamic> lastSearchedSongIds =
        GetStorage().read(Prefs.listLastSearches) ?? [];

    List<Song> lastSearchedSongs = [];

    for (int songId in lastSearchedSongIds) {
      var song = await isar.getSongById(songId);
      if (song != null) lastSearchedSongs.add(song);
    }

    isShowingLastSearched.value = true;
    searchResultLyricsBeginPosition.value = 100;
    searchResults.value = lastSearchedSongs;
  }

  void doSearch() async {
    final searchVal = searchValue.value.trim();
    // only numeric search
    if (searchVal.isEmpty) {
      searchResults.clear();
      showLastSearchedSongs();
    } else {
      isShowingLastSearched.value = false;
      // Search song number and title
      final titleSearchResults = await isar.getTitleSearchResults(searchVal);

      if (int.tryParse(searchVal) == null) {
        // Search lyrics and remove duplicates
        final lyricsSearchResults = (await isar
            .getLyricsSearchResults(searchVal))
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

  void import(version) async {
    if (GetStorage().read(Prefs.numDBversion) != ReleaseConfig.dbversion) {
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
      GetStorage().write(Prefs.numDBversion, version);
    } else {
      isDBfilled.value = true;
    }
    //log("duration ${stowa.elapsed}");
  }
}
