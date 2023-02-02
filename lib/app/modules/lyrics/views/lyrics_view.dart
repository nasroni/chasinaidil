import 'package:chasinaidil/app/modules/lyrics/views/songtitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'songoptionsdialog.dart';
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
        middle: SizedBox(
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
            child: SongTitle(song: song),
          ),
        ),
        //trailing: const Icon(Icons.play_circle_outline_sharp, ),
      ),
      body: Column(
        children: [
          Expanded(
              child: GetBuilder<LyricsController>(
                  id: 'zoomtextview',
                  builder: (_) {
                    // ignore: prefer_const_constructors
                    return ZoomTextView();
                  })),
        ],
      ),
    );
  }
}
