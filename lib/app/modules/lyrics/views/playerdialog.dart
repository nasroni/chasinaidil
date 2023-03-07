import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/positionseekwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PlayerDialog extends StatelessWidget {
  const PlayerDialog({
    super.key,
    required this.viewController,
  });

  final LyricsController viewController;

  @override
  Widget build(BuildContext context) {
    AppController appc = Get.find();
    appc.player.open(
      viewController.song.audio,
      autoStart: false,
      showNotification: true,
    );

    return AlertDialog(
      alignment: Alignment.topRight,
      insetPadding: const EdgeInsets.only(top: 55, right: 10),
      elevation: 30,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      //contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      backgroundColor: Colors.blueGrey.shade100,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints.tight(const Size.fromHeight(500)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: context.theme.primaryColor,
                  blurRadius: 20,
                  spreadRadius: -10,
                  offset: const Offset(0, 0),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: appc.player.builderPlayerState(
                  builder: (context, PlayerState state) {
                    if (appc.player.getCurrentAudioImage?.path != null &&
                        state != PlayerState.stop) {
                      return Image.asset(
                        appc.player.getCurrentAudioImage?.path ?? '',
                        width: 180,
                        height: 180,
                      );
                    }
                    return Container(
                      color: Colors.grey,
                      width: 180,
                      height: 180,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: appc.player.current,
              builder: (context, _) {
                return Text(appc.player.getCurrentAudioTitle);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: appc.player.current,
              builder: (context, _) {
                return Text(appc.player.getCurrentAudioArtist);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            appc.player.builderRealtimePlayingInfos(
              builder: (context, RealtimePlayingInfos infos) {
                return PositionSeekWidget(
                  currentPosition: infos.currentPosition,
                  duration: infos.duration,
                  seekTo: (val) => appc.player.seek(val),
                );
              },
            ),
            /*StreamBuilder(
              stream: (appc.player.realtimePlayingInfos),
              builder: (context, snapshot) {
                if (snapshot.data == null) return Container();
                RealtimePlayingInfos data = snapshot.data!;
                return Slider(
                  thumbColor: Colors.transparent,
                  value: appc.isSeeking.value
                      ? appc.seekingVal.value
                      : data.currentPosition.inSeconds.toDouble(),
                  max: appc.player.current.value?.audio.duration.inSeconds
                          .toDouble() ??
                      360,
                  onChangeStart: (_) => appc.isSeeking.value = true,
                  onChangeEnd: (value) {
                    appc.isSeeking.value = false;
                    appc.player.seek(Duration(
                      seconds: value.round(),
                    ));
                  },
                  onChanged: (value) => appc.seekingVal.value = value,
                );
              },
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appc.player.builderRealtimePlayingInfos(
                  builder: (context, RealtimePlayingInfos infos) {
                    if (infos.isBuffering) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: const CupertinoActivityIndicator(
                          radius: 20,
                        ),
                      );
                    }
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      disabledColor: Colors.red,
                      onPressed: () => appc.player.playOrPause(),
                      child: Icon(
                        infos.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        color: context.theme.primaryColor,
                        size: 60,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
