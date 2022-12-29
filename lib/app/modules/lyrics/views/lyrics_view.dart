import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lyrics_controller.dart';

class LyricsView extends GetView<LyricsController> {
  const LyricsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LyricsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LyricsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
