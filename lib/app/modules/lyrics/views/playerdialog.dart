import 'dart:developer';

import 'package:al_downloader/al_downloader.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/positionseekwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerDialog extends StatelessWidget {
  const PlayerDialog({
    super.key,
    required this.viewController,
  });

  final LyricsController viewController;

  @override
  Widget build(BuildContext context) {
    AppController appc = Get.find();
    /*appc.player.open(
      viewController.song.audio,
      autoStart: false,
      showNotification: true,
    );*/

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
      content: PlayerView(appc: appc),
    );
  }
}

class PlayerView extends StatelessWidget {
  PlayerView({
    super.key,
    required this.appc,
  });

  final AppController appc;
  final LyricsController viewController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
            child: appc.player.builderPlayerState(builder: (_, __) {
              return PlayerAlbumImage(
                imagePath: appc.player.getCurrentAudioImage?.path,
              );
            }),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appc.player.builderPlayerState(
                //builder: (context, RealtimePlayingInfos infos) {
                builder: (context, var infos) {
                  if (true) {
                    return CupertinoButton(
                      child: GetBuilder<AppController>(
                          id: 'updateViews',
                          builder: (context) {
                            if (viewController.song.isDownloaded) {
                              return const Icon(Icons.help_outline);
                            } else {
                              return Obx(
                                () {
                                  return appc.isDownloading.value
                                      ? const Icon(Icons.download)
                                      : const Icon(Icons.access_alarm);
                                },
                              );
                            }
                          }),
                      onPressed: () async {
                        await appc.downloadSong(viewController.song);
                      },
                    );
                  }
                  /*if (infos.isBuffering) {
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
                  );*/
                },
              ),
              Obx(() => Text("${appc.downloadPercentage}")),
            ],
          ),
        ],
      ),
    );
  }
}

class PlayerAlbumImage extends StatelessWidget {
  const PlayerAlbumImage({
    super.key,
    required this.imagePath,
  });

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Builder(
        builder: (_) {
          if (imagePath != null) {
            return Image.asset(
              imagePath ?? '',
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
    );
  }
}
