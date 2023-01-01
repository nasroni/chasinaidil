import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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

    rendered = text.map((line) {
      if (line.startsWith('#')) {
        return Container(
          padding: context.isLandscape
              ? const EdgeInsets.fromLTRB(50, 8, 48, 4)
              : const EdgeInsets.fromLTRB(10, 8, 8, 4),
          child: Text(
            line.substring(1),
            style: titleStyle,
          ),
        );
      }

      toggleBW = !toggleBW;

      return Container(
        padding: context.isLandscape
            ? const EdgeInsets.symmetric(vertical: 10, horizontal: 50)
            : const EdgeInsets.all(10),
        color: toggleBW ? const Color(0xfff3f3f3) : Colors.white,
        width: double.maxFinite,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: line.split(' ').map((word) {
            var text = '', chord = '';
            if (word.contains('[')) {
              bool chordToggle = false;
              int chordAhead = 0;
              word.split('').forEach((letter) {
                if (letter == '[') {
                  chordToggle = true;
                  chordAhead = 0;
                } else if (letter == ']') {
                  chordToggle = false;
                } else if (chordToggle) {
                  if (letter == 'b') {
                    letter = '♭';
                  }
                  chord += letter;
                  chordAhead++;
                } else {
                  text += letter;
                  if (chordAhead <= 0) {
                    chord = '$chord ';
                  }
                  chordAhead--;
                }
              });
            } else {
              text = word;
            }
            text = '$text ';
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
