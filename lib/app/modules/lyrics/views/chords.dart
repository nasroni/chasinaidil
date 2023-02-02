import 'dart:developer';

import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChordsView extends StatelessWidget {
  final TextStyle lyricsStyle;
  final TextStyle chordsStyle;
  final TextStyle titleStyle;

  final double currentZoom;

  ChordsView(
      {super.key,
      required this.lyricsStyle,
      required this.chordsStyle,
      required this.titleStyle,
      required this.currentZoom});

  final LyricsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var textRaw = controller.isChordMode
        ? controller.song.textWChords
        : controller.song.lyrics;

    final List<String> text = textRaw.split('\n');

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
          lineText = "Купрук";
        } else if (sanitizedLine == '#part') {
          return Divider(
            color: Colors.black26,
            endIndent: context.width / 3,
            indent: context.width / 3,
            thickness: 1.5 * currentZoom,
            height: 30 * currentZoom,
          );
        } else {
          lineText = line;
        }

        double paddingRight = controller.isChordMode ? 8 : 30;

        return Container(
          padding: context.isLandscape
              ? EdgeInsets.fromLTRB(
                  50, 25 * currentZoom * 0.8, 50, 2 * currentZoom * 0.8)
              : EdgeInsets.fromLTRB(30, 25 * currentZoom * 0.8, paddingRight,
                  2 * currentZoom * 0.8),
          width: context.width,
          child: Text(
            lineText,
            textAlign: controller.isChordMode ? null : TextAlign.center,
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

      double paddingRight = controller.isChordMode ? 10 : 20;

      // double line render (one chord and one lyric)
      return Container(
        // notch and design
        padding: context.isLandscape
            ? EdgeInsets.symmetric(
                vertical: 10 * currentZoom * 0.8, horizontal: 50)
            : EdgeInsets.fromLTRB(
                20, 5 * currentZoom * 0.8, paddingRight, 5 * currentZoom * 0.8),
        // backgroundcolor
        //color: toggleBW ? const Color(0xfff0f0f0) : Colors.white,
        color: Colors.white,
        width: double.maxFinite,
        // linebreak wordwise
        child: controller.isChordMode
            ? WordWiseWithChords(
                words: words,
                controller: controller,
                lastWord: lastWord,
                chordsStyle: chordsStyle,
                lyricsStyle: lyricsStyle,
              )
            : WordWiseLyrics(words: words, lyricsStyle: lyricsStyle),
      );
    }).toList();

    // add margin to bottom
    rendered.add(Container(
      height: context.height / 3,
      width: context.width,
    ));

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

class WordWiseLyrics extends StatelessWidget {
  const WordWiseLyrics(
      {super.key, required this.words, required this.lyricsStyle});

  final List<String> words;
  final TextStyle lyricsStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      words.join(' '),
      textAlign: TextAlign.center,
      style: lyricsStyle,
    );
  }
}

class WordWiseWithChords extends StatelessWidget {
  const WordWiseWithChords({
    super.key,
    required this.words,
    required this.controller,
    required this.lastWord,
    required this.chordsStyle,
    required this.lyricsStyle,
  });

  final List<String> words;
  final LyricsController controller;
  final String lastWord;
  final TextStyle chordsStyle;
  final TextStyle lyricsStyle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
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

              if (chordAhead > 0) {
                chord += ' ';
                text += '_' * chordAhead;
              }
              chordAhead = 0;
              currentChord = "";
            }
            // end of chord
            else if (letter == ']') {
              chordToggle = false;
              String transposedChord;
              if (currentChord.contains('/')) {
                var chordParts = currentChord.split('/');
                transposedChord = controller.transpose(chordParts[0]) +
                    '/' +
                    controller.transpose(chordParts[1]);
              } else {
                transposedChord = controller.transpose(currentChord);
              }
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
          chord = '$chord '.replaceAll('b', '♭');
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
    );
  }
}
