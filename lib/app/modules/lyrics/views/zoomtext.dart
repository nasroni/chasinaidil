import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/chords.dart';
import 'package:chasinaidil/theme.dart';
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:get/get.dart';

class ZoomTextView extends StatefulWidget {
  const ZoomTextView({super.key});

  @override
  State<ZoomTextView> createState() => _ZoomTextViewState();
}

class _ZoomTextViewState extends State<ZoomTextView> {
  final LyricsController controller = Get.find();

  double scaleFactor = 1.0;
  double baseScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    TextStyle chordsStyle = AppTheme.chordText;
    TextStyle lyricsStyle = AppTheme.chordLyricsText;
    TextStyle titleStyle = AppTheme.lyricsTitleText;

    chordsStyle =
        chordsStyle.apply(fontSizeFactor: scaleFactor, fontSizeDelta: 1.5);
    lyricsStyle =
        lyricsStyle.apply(fontSizeFactor: scaleFactor, fontSizeDelta: 1.5);
    titleStyle =
        titleStyle.apply(fontSizeFactor: scaleFactor, fontSizeDelta: 1.5);

    return XGestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleStart: (details) {
        baseScaleFactor = scaleFactor;
      },
      onScaleUpdate: (details) {
        double factor = baseScaleFactor * details.scale;
        if (factor < 0.5) factor = 0.5;
        setState(() {
          scaleFactor = factor;
        });
        //log('test ${details.scale}');
      },
      child: Container(
        color: Colors.white,
        height: context.height,
        width: context.width,
        child: SingleChildScrollView(
          child: ChordsView(
            titleStyle: titleStyle,
            lyricsStyle: lyricsStyle,
            chordsStyle: chordsStyle,
          ),
        ),
      ),
    );
  }
}
