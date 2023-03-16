import 'dart:developer';

import 'package:chasinaidil/app/modules/app_controller.dart';
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
      padding: EdgeInsets.only(
        // from top of display
        top: 45,
        // from sides of display
        right: context.width / 6,
        left: context.width / 6,
        bottom: 0,
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
                color: context.isDarkMode
                    ? context.theme.shadowColor
                    : context.theme.unselectedWidgetColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 70,
                    spreadRadius: -25,
                    color: context.isDarkMode
                        ? Colors.grey.shade800
                        : context.theme.primaryColor,
                  )
                ],
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
                    newViewMode: ViewModes.lyrics,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  PopupCustomMenuItem(
                    text: 'Бо Аккорд',
                    icon: CupertinoIcons.guitars,
                    bold: controller.isChordMode,
                    newViewMode: ViewModes.chords,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  PopupCustomMenuItem(
                    text: 'Бо Нота',
                    icon: CupertinoIcons.music_note_list,
                    bold: controller.isSheetMode,
                    newViewMode: ViewModes.sheet,
                  ),
                  const Divider(thickness: 5, height: 5),
                  controller.isChordMode ? TransposeButtons() : Container(),
                  controller.isChordMode
                      ? const Divider(thickness: 5, height: 5)
                      : Container(),
                  PopupCustomMenuItem(
                    text: 'Ворид ба плейлист',
                    icon: Icons.playlist_add,
                    onTapFunction: (_) => Get.find<AppController>()
                        .playlistDialog(controller.song),
                  ),
                  const Divider(
                    height: 0,
                  ),
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
                          'Барои аккордҳо, нотаҳо ва сабтҳои mp3, ин барномаро боргирӣ кунед:\n'
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
