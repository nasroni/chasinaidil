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
                  ),
                  const Divider(
                    height: 0,
                  ),
                  PopupCustomMenuItem(
                    text: 'Бо Аккорд',
                    icon: CupertinoIcons.guitars,
                    bold: controller.isChordMode,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  PopupCustomMenuItem(
                    text: 'Бо Нота',
                    icon: CupertinoIcons.music_note_list,
                    bold: controller.isSheetMode,
                  ),
                  const Divider(thickness: 5, height: 5),
                  controller.isChordMode ? TransposeButtons() : Container(),
                  controller.isChordMode
                      ? const Divider(thickness: 5, height: 5)
                      : Container(),
                  const PopupCustomMenuItem(
                    text: 'Фиристодан ...',
                    icon: CupertinoIcons.share,
                    position: -1,
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
