import 'dart:math';

import 'package:chasinaidil/app/flutter_rewrite/navbar.dart';
import 'package:chasinaidil/app/modules/lyrics/views/songtitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:pdfx/pdfx.dart';
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

    /*GetPlatform.isAndroid
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
            SystemUiOverlay.top,
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);*/

    final Song song = controller.song;

    return Scaffold(
      appBar: MyCupertinoNavigationBar(
        backgroundColor: context.theme.shadowColor,
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
            color: context.theme.shadowColor,
            child: SongTitle(song: song),
          ),
        ),
        //trailing: const Icon(Icons.play_circle_outline_sharp, ),
      ),
      body: GetBuilder<LyricsController>(
          id: 'songcontentview',
          builder: (ctx) {
            if (controller.isSheetMode) {
              /*return PdfView(
                controller: controller.pdfController,
                scrollDirection: Axis.vertical,
              );*/

              //return PdfViewer.openAsset(song.sheetPath);
              return PdfViewer.openAsset(
                song.sheetPath,
                params: PdfViewerParams(
                  minScale: 0.1,
                  scrollDirection: Axis.vertical,
                  boundaryMargin: context.isLandscape
                      ? const EdgeInsets.fromLTRB(400, 0, 400, 200)
                      : const EdgeInsets.fromLTRB(1, 0, 1, 300),
                  /*layoutPages: (viewSize, pages) {
                    List<Rect> rect = [];
                    final viewWidth = viewSize.width;
                    final viewHeight = viewSize.height;
                    final maxHeight = pages.fold<double>(
                        0.0, (maxHeight, page) => max(maxHeight, page.height));
                    final ratio = viewHeight / maxHeight;
                    var top = 0.0;
                    for (var page in pages) {
                      final width = page.width * ratio;
                      final height = page.height * ratio;
                      final left = viewWidth > viewHeight
                          ? (viewWidth / 2) - (width / 2)
                          : 0.0;
                      rect.add(Rect.fromLTWH(left, top, width, height));
                      top += height + 8 /* padding */;
                    }
                    return rect;
                  },*/
                ),
              );
            }
            return Column(
              children:
                  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
                  [Expanded(child: ZoomTextView())],
            );
          }),
    );
  }
}
