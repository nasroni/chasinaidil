import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/types/song.dart';

class LyricsController extends GetxController {
  final Song song = Get.arguments;

  final RxInt viewModeInt = 2.obs;

  bool get isLyricsMode => viewModeInt.value == 1;
  bool get isChordMode => viewModeInt.value == 2;
  bool get isSheetMode => viewModeInt.value == 3;

  final RxInt transposeCount = 0.obs;

  void decreaseTranspose() {
    transposeCount.value--;
    update(['chordview']);
  }

  void increaseTranspose() {
    transposeCount.value++;
    update(['chordview']);
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
