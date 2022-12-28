import 'dart:developer';
import 'dart:io';

import 'package:chasinaidil/app/data/services/import_service.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/song.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final isSearchActive = false.obs;
  final isDBfilled = false.obs;

  final IsarService isar = Get.find();
  final ImportService importService = ImportService();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void openSearch() => isSearchActive.value = true;
  void closeSearch() => isSearchActive.value = false;

  void import() async {
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
  }
}
