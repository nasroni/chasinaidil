import 'package:chasinaidil/app/flutter_rewrite/navbar.dart';
import 'package:chasinaidil/app/modules/lyrics/views/songtitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'playerdialog.dart';
import 'songoptionsdialog.dart';
import 'zoomtext.dart';

class LyricsView extends GetView<LyricsController> {
  const LyricsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight
    ]);*/

    /*GetPlatform.isAndroid
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
            SystemUiOverlay.top,
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);*/

    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft
      ],
    );

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
        trailing: CupertinoButton(
          onPressed: () => Get.dialog(
              PlayerDialog(
                viewingSong: controller.song,
              ),
              barrierColor: Colors.transparent,
              barrierDismissible: true),
          padding: EdgeInsets.zero,
          minSize: kMinInteractiveDimensionCupertino,
          alignment: Alignment.centerRight,
          child: Icon(
            CupertinoIcons.playpause,
            color: context.theme.primaryColor,
            size: 24,
          ),
        ),
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
                  panAxis: PanAxis.aligned,
                  boundaryMargin: context.isLandscape
                      ? const EdgeInsets.fromLTRB(400, 0, 400, 200)
                      : const EdgeInsets.fromLTRB(1, 0, 1, 300),
                ),
              );
            }
            // ignore: prefer_const_constructors
            return Column(
              children:
                  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
                  [Expanded(child: ZoomTextView())],
            );
          }),
    );
  }
}
