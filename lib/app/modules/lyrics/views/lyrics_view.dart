import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../data/types/song.dart';
import '../controllers/lyrics_controller.dart';
import 'zoomtext.dart';

class LyricsView extends GetView<LyricsController> {
  const LyricsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight
    ]);
    GetPlatform.isAndroid
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [])
        : null;
    final Song song = controller.song;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        trailing: const Icon(Icons.play_circle_outline_sharp),
        middle: Container(
          width: context.width / 2,
          child: CupertinoButton(
            onPressed: () {
              Get.dialog(
                SongOptionsDialog(controller: controller),
                barrierColor: Colors.transparent,
              );
            },
            minSize: 0,
            padding: const EdgeInsets.all(2),
            color: Get.theme.scaffoldBackgroundColor,
            child: Text(
              "${song.songNumber}. ${song.title}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      /*appBar: AppBar(
        title: Text('asdf'),
      ),*/
      body: Column(
        children: const [
          Expanded(child: ZoomTextView()),
        ],
      ),
    );
  }
}

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
        vertical: 45,
        horizontal: context.width / 6,
      ),
      height: 60,
      child: Material(
        color: Colors.transparent,
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
                  PopupCustomMenuItem(
                    text: 'Матн',
                    icon: CupertinoIcons.text_quote,
                    bold: controller.isLyricsMode,
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
                  const Divider(
                    thickness: 5,
                    height: 5,
                  ),
                  controller.isChordMode ? TransposeButtons() : Container(),
                  controller.isChordMode
                      ? const Divider(
                          thickness: 5,
                          height: 5,
                        )
                      : Container(),
                  const PopupCustomMenuItem(
                    text: 'Рой кардан ...',
                    icon: CupertinoIcons.share,
                  ),
                ],
              ),
            ),
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

class PopupCustomMenuItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool width;
  final bool bold;

  const PopupCustomMenuItem(
      {super.key,
      required this.text,
      required this.icon,
      this.width = true,
      this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ? context.width / 1.33 : null,
      height: kMinInteractiveDimensionCupertino,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.all(0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}

class TransposeButtons extends StatelessWidget {
  TransposeButtons({super.key});

  final LyricsController controller = Get.find();

  final squareButtonSize = const MaterialStatePropertyAll(Size.square(10));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kMinInteractiveDimensionCupertino,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: kMinInteractiveDimensionCupertino,
            height: kMinInteractiveDimensionCupertino,
            child: TextButton(
              style: buttonMyCustomStyle(),
              onPressed: () => controller.decreaseTranspose(),
              child: const Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
          const VerticalDivider(
            width: 0,
          ),
          Expanded(
            child: TextButton(
              style: buttonMyCustomStyle(),
              onPressed: () => controller.resetTranspose(),
              child: const PopupCustomMenuItem(
                text: 'Транспоз',
                icon: null,
                width: false,
              ),
            ),
          ),
          const VerticalDivider(
            width: 0,
          ),
          SizedBox(
            width: kMinInteractiveDimensionCupertino,
            height: kMinInteractiveDimensionCupertino,
            child: TextButton(
              onPressed: () => controller.increaseTranspose(),
              style: buttonMyCustomStyle(),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle buttonMyCustomStyle() {
    //const MaterialStateProperty<Size?>? size = null;

    return ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      elevation: const MaterialStatePropertyAll(0),
      /*fixedSize: size,
      minimumSize: size,
      maximumSize: size,*/
      textStyle: MaterialStatePropertyAll(Get.textTheme.bodyMedium),
      shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const Color.fromRGBO(209, 209, 209, 1);
        }
        return null;
      }),
    );
  }
}
