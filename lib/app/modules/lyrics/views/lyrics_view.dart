import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/types/song.dart';
import '../controllers/lyrics_controller.dart';
import 'zoomtext_view.dart';

class LyricsView extends GetView<LyricsController> {
  const LyricsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
