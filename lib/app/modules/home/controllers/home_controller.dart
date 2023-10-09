import 'package:chasinaidil/app/data/services/import_service.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/types/song.dart';

enum SongBook { chasinaidil, chashma, others, playlists }

class HomeController extends GetxController {
  final RxInt count = 0.obs;
  final RxBool isSearchActive = false.obs;
  //final RxBool isDBfilled = false.obs;

  final RxString searchValue = "".obs;

  static final IsarService isar = Get.find();
  static final ImportService importService = ImportService();

  final RxList<Song> searchResults = RxList<Song>([]);
  final RxInt searchResultLyricsBeginPosition = 0.obs;
  final RxBool isShowingLastSearched = true.obs;

  final RxBool isChasinaiDilOpen = true.obs;
  final RxBool isChashmaOpen = false.obs;
  final RxBool isOthersOpen = false.obs;
  final RxBool isPlaylistsOpen = true.obs;

  late final Worker searchWorker;

  final TextEditingController searchEditingController = TextEditingController();

  @override
  void onInit() {
    showLastSearchedSongs();
    restoreOpenState();
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

  void restoreOpenState() {
    isChasinaiDilOpen.value =
        GetStorage().read(Prefs.isChasinaiDilOpen) ?? isChasinaiDilOpen.value;
    isChashmaOpen.value =
        GetStorage().read(Prefs.isChashmaOpen) ?? isChashmaOpen.value;
    isOthersOpen.value =
        GetStorage().read(Prefs.isOthersOpen) ?? isOthersOpen.value;
    isPlaylistsOpen.value =
        GetStorage().read(Prefs.isPlaylistsOpen) ?? isPlaylistsOpen.value;
  }

  void toggleOpenState(SongBook whichBook) {
    switch (whichBook) {
      case SongBook.chasinaidil:
        isChasinaiDilOpen.value = !isChasinaiDilOpen.value;
        GetStorage().write(Prefs.isChasinaiDilOpen, isChasinaiDilOpen.value);
        break;
      case SongBook.chashma:
        isChashmaOpen.value = !isChashmaOpen.value;
        GetStorage().write(Prefs.isChashmaOpen, isChashmaOpen.value);
        break;
      case SongBook.others:
        isOthersOpen.value = !isOthersOpen.value;
        GetStorage().write(Prefs.isOthersOpen, isOthersOpen.value);
        break;
      case SongBook.playlists:
        isPlaylistsOpen.value = !isPlaylistsOpen.value;
        GetStorage().write(Prefs.isPlaylistsOpen, isPlaylistsOpen.value);
    }
  }

  static String giveBookTitle(SongBook whichBook) {
    switch (whichBook) {
      case SongBook.chasinaidil:
        return 'Хазинаи Дил';
      case SongBook.chashma:
        return 'Чашма';
      case SongBook.others:
        return 'Дигар сурудҳо';
      case SongBook.playlists:
        return 'Плейлистҳо';
    }
  }

  static SongBook giveSongBookEnum(String title) {
    switch (title) {
      case 'Хазинаи Дил':
        return SongBook.chasinaidil;
      case 'Чашма':
        return SongBook.chashma;
      case 'Дигар сурудҳо':
        return SongBook.others;
      case 'Плейлистҳо':
        return SongBook.playlists;
      case 'chasinaidil':
        return SongBook.chasinaidil;
      case 'chashma':
        return SongBook.chashma;
      default:
        return SongBook.others;
    }
  }

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
}
