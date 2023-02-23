import 'dart:developer';

import 'package:chasinaidil/prefs.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdfx/pdfx.dart';

import '../../../data/types/song.dart';

enum ViewModes { lyrics, chords, sheet }

class LyricsController extends GetxController {
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  final Song song = Get.arguments;

  final Rx<ViewModes> viewMode = ViewModes.values
      .firstWhere(
        (element) => element.name == GetStorage().read(Prefs.mode),
        orElse: () => ViewModes.lyrics,
      )
      .obs;
  bool get isLyricsMode => viewMode.value == ViewModes.lyrics;
  bool get isChordMode => viewMode.value == ViewModes.chords;
  bool get isSheetMode => viewMode.value == ViewModes.sheet;

  /*PdfController get pdfController {
    _pdfController ??= PdfController(
      document: PdfDocument.openAsset(song.sheetPath),
    );
    return _pdfController!;
  }

  PdfController? _pdfController;*/

  final RxInt transposeCount = 0.obs;

  void decreaseTranspose() {
    transposeCount.value--;
    update(['textview']);
  }

  void increaseTranspose() {
    transposeCount.value++;
    update(['textview']);
  }

  void resetTranspose() {
    transposeCount.value = 0;
    update(['textview']);
  }

  void setViewMode(ViewModes newViewMode) {
    viewMode.value = newViewMode;
    GetStorage().write(Prefs.mode, newViewMode.name);
    update(['songcontentview']);
  }

  transpose(String currentChord) {
    if (transposeCount.value == 0) return currentChord;
    int transposeDistance = transposeCount.value;
    List<String> allChordPositions = [
      "C",
      "C#",
      "D",
      "D#",
      "E",
      "F",
      "F#",
      "G",
      "G#",
      "A",
      "Bb",
      "B"
    ];
    String transposePart =
        RegExp(r'[ABCDEFGH](b|\#)?').firstMatch(currentChord)?[0] ?? "";
    /*String modifierPart =
        RegExp(r'm?[0-9]?').firstMatch(currentChord)?[0] ?? "";*/
    String modifierPart = currentChord.substring(transposePart.length);

    if (transposePart.isEmpty) {
      log("ERROR WITH CHORD: $currentChord");
      return currentChord;
    }

    if (transposePart.contains('b')) {
      transposeDistance--;
      transposePart = transposePart.replaceAll('b', '');
    }
    int currentPositionInChordsTable = allChordPositions.indexOf(transposePart);

    if (currentPositionInChordsTable == -1) {
      log("ERROR WITH CHORD-1: $currentChord");
      return currentChord;
    }
    int targetPosition = currentPositionInChordsTable + transposeDistance;
    if (targetPosition >= 0) {
      while (targetPosition >= allChordPositions.length) {
        targetPosition -= allChordPositions.length;
      }
    } else {
      while (targetPosition < 0) {
        targetPosition += allChordPositions.length;
      }
    }

    String newChordTransposePart = allChordPositions[targetPosition];

    return newChordTransposePart + modifierPart;
  }
}
