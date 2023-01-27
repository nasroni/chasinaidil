import 'dart:developer';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/lyrics_controller.dart';
import 'popupcustommenuitem.dart';
import 'transposebuttons.dart';

class SongOptionsDialog extends StatelessWidget {
  const SongOptionsDialog({
    super.key,
    required this.controller,
  });

  final LyricsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        // from top of display
        vertical: 45,
        // from sides of display
        horizontal: context.width / 6,
      ),
      child: Material(
        // background where you can click to let it disappear has to be transparent
        color: Colors.transparent,
        // column, with a container containing the content
        // below a expanded to take up remaining space, make it transparent and clickable
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(blurRadius: 70, spreadRadius: -25)],
              ),
              child: Column(
                children: [
                  //
                  // starting here with all the entries of the menu
                  PopupCustomMenuItem(
                    text: 'Матн',
                    icon: CupertinoIcons.text_quote,
                    bold: controller.isLyricsMode,
                    position: 1,
                    newViewMode: ViewModes.Lyrics,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  PopupCustomMenuItem(
                    text: 'Бо Аккорд',
                    icon: CupertinoIcons.guitars,
                    bold: controller.isChordMode,
                    newViewMode: ViewModes.Chords,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  PopupCustomMenuItem(
                    text: 'Бо Нота',
                    icon: CupertinoIcons.music_note_list,
                    bold: controller.isSheetMode,
                    newViewMode: ViewModes.Sheet,
                  ),
                  const Divider(thickness: 5, height: 5),
                  controller.isChordMode ? TransposeButtons() : Container(),
                  controller.isChordMode
                      ? const Divider(thickness: 5, height: 5)
                      : Container(),
                  PopupCustomMenuItem(
                    text: 'Фиристодан ...',
                    icon: CupertinoIcons.share,
                    position: -1,
                    onTapFunction: (var contextVar) async {
                      final box = contextVar.findRenderObject() as RenderBox?;

                      int verseCount = 0;

                      var lyrics = controller.song.lyrics.splitMapJoin(
                        RegExp(r'#\w+'),
                        onMatch: (matches) {
                          var match = matches[0];
                          if (match == '#verse') {
                            verseCount++;
                            return "\nБанди $verseCount";
                          } else if (match == '#chorus') {
                            return "\nБандгардон";
                          } else if (match == '#outro') {
                            return "\nХотима";
                          } else if (match == '#intro') {
                            return "\nСаршавӣ";
                          } else if (match == '#bridge') {
                            return "\nКупрук";
                          }
                          return match ?? "";
                        },
                        onNonMatch: (nonMatch) => nonMatch,
                      );

                      var text =
                          '${controller.song.songNumber}. ${controller.song.title}\n'
                          '$lyrics\n\n'
                          'Суруд аз ${controller.song.book}\n\n'
                          'Барои аккордҳо, нотаҳо ва сабтҳои mp3, ин барномаро бозгирӣ кунед:\n'
                          'Android: https://play.google.com/store/apps/details?id=one.nasroni.chasinaidil\n'
                          'iPhone: https://apps.apple.com/ch/app/хазинаи-дил/id1665980806';
                      log(text);
                      await Share.share(
                        text,
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size,
                      );
                    },
                  ),
                ],
              ),
            ),
            // Close popup menu and fill available space with this "button"
            Expanded(
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
