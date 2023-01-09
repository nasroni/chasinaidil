import 'dart:developer';

import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChordsView extends StatelessWidget {
  final TextStyle lyricsStyle;
  final TextStyle chordsStyle;
  final TextStyle titleStyle;

  ChordsView(
      {super.key,
      required this.lyricsStyle,
      required this.chordsStyle,
      required this.titleStyle});

  final LyricsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<String> text = controller.song.textWChords.split('\n');
    List<Widget> rendered;

    bool toggleBW = false;
    int verseCount = 0;

    rendered = text.map((String line) {
      // jump over last line
      if (line.trim().isEmpty) return Container();

      // song structure
      if (line.startsWith('#')) {
        String sanitizedLine =
            (RegExp(r'([A-Za-z\#])+').firstMatch(line))?[0] ?? "";
        String lineText;
        if (sanitizedLine == '#verse') {
          verseCount++;
          lineText = "Банди $verseCount";
        } else if (sanitizedLine == '#chorus') {
          lineText = "Бандгардон";
        } else if (sanitizedLine == '#outro') {
          lineText = "Хотима";
        } else if (sanitizedLine == '#intro') {
          lineText = "Саршавӣ";
        } else if (sanitizedLine == '#bridge') {
          lineText = "Bridge";
        } else if (sanitizedLine == '#part') {
          return Divider(
            color: Colors.black26,
            endIndent: context.width / 3,
            indent: context.width / 3,
            thickness: 1.5,
            height: 30,
          );
        } else {
          lineText = line;
        }

        return Container(
          padding: context.isLandscape
              ? const EdgeInsets.fromLTRB(50, 8, 48, 4)
              : const EdgeInsets.fromLTRB(10, 8, 8, 4),
          child: Text(
            lineText,
            style: titleStyle,
          ),
        );
      }

      // line focusing
      toggleBW = !toggleBW;

      // remove whitespace before repeat sign
      var trimmedLine = line.trim();
      if (trimmedLine[trimmedLine.length - 2] == ":") {
        trimmedLine = trimmedLine.replaceAll(RegExp(r' \:\|'), ':|');
      }
      List<String> words = trimmedLine.split(' ');
      String lastWord = words[words.length - 1];

      // double line render (one chord and one lyric)
      return Container(
        // notch and design
        padding: context.isLandscape
            ? const EdgeInsets.symmetric(vertical: 10, horizontal: 50)
            : const EdgeInsets.all(10),
        // backgroundcolor
        color: toggleBW ? const Color(0xfff8f8f8) : Colors.white,
        width: double.maxFinite,
        // linebreak wordwise
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          // word render
          children: words.map((word) {
            var text = '', chord = '';
            // chord logic
            if (word.contains('[')) {
              bool chordToggle = false;
              int chordAhead = 0;
              String currentChord = "";
              word.split('').forEach((letter) {
                // start of chord
                if (letter == '[') {
                  chordToggle = true;
                  log("$currentChord - $chordAhead");

                  if (chordAhead > 0) {
                    chord += ' ';
                    text += '-' * chordAhead;
                  }
                  chordAhead = 0;
                  currentChord = "";
                }
                // end of chord
                else if (letter == ']') {
                  chordToggle = false;
                  String transposedChord = controller.transpose(currentChord);
                  chordAhead = transposedChord.length + 1;
                  chord += transposedChord;
                }
                // chord displaying
                else if (chordToggle) {
                  currentChord += letter;
                  // nice rendering of flat
                  /*if (letter == 'b') {
                    letter = '♭';
                  }*/
                }
                // text rendering
                else {
                  text += letter;
                  if (chordAhead <= 1) {
                    chord += ' ';
                  }
                  chordAhead--;
                }
              });
            }
            // plain text rendering
            else {
              text = word;
            }
            // add removed word separation if not last word or after repeat sign
            if (lastWord != word && text != "|:") {
              text = '$text ';
            }

            // display chords and lyrics
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  chord,
                  style: chordsStyle,
                ),
                Text(
                  text,
                  style: lyricsStyle,
                )
              ],
            );
          }).toList(),
        ),
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rendered,
        )
      ],
    );
  }
}
