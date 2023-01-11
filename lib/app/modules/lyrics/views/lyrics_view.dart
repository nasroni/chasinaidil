import 'dart:developer';

import 'package:chasinaidil/app/modules/lyrics/views/chordactions.dart';
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
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),*/
        trailing: Icon(Icons.play_circle_outline_sharp),
        middle: Container(
          width: context.width / 2,
          child: CupertinoButton(
            onPressed: () {},
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
        children: [
          controller.isChordMode ? ChordActions() : Container(),
          const Expanded(child: ZoomTextView()),
        ],
      ),
    );
  }
}
