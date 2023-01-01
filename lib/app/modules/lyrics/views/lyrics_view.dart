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
    final Song song = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
        centerTitle: true,
      ),
      body: const ZoomTextView(),
    );
  }
}
