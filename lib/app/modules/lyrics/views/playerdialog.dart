import 'dart:developer';

import 'package:al_downloader/al_downloader.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/positionseekwidget.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
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
      insetPadding: const EdgeInsets.only(top: 55, right: 10, left: 10),
      elevation: 30,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      //contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      backgroundColor: context.theme.dialogBackgroundColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
      constraints: BoxConstraints.tight(const Size(220, 500)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayerAlbumImageWithBox(appc: appc),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: appc.player.current,
            builder: (context, _) {
              return Text(
                appc.player.getCurrentAudioTitle,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: context.theme.textTheme.displayLarge
                    ?.copyWith(fontSize: 20),
              );
            },
          ),
          const SizedBox(
            height: 7,
          ),
          StreamBuilder(
            stream: appc.player.current,
            builder: (context, _) {
              return Text(
                appc.player.getCurrentAudioArtist,
                textAlign: TextAlign.left,
                style: context.theme.textTheme.displayMedium
                    ?.copyWith(fontSize: 15, color: Colors.grey),
              );
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

class PlayerAlbumImageWithBox extends StatelessWidget {
  const PlayerAlbumImageWithBox({
    super.key,
    required this.appc,
  });

  final AppController appc;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        String title = appc.player.getCurrentAudioTitle;
        IsarService isar = Get.find();
        Song? song = await isar.getSongByTitle(title);
        LyricsController lyricsController = Get.find();
        lyricsController.song = song!;
        await Get.offAndToNamed(Routes.LYRICS, arguments: song);
      },
      padding: EdgeInsets.zero,
      child: Container(
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
              width: 230,
              height: 230,
            );
          }
          return Container(
            color: Colors.grey,
            width: 230,
            height: 230,
          );
        },
      ),
    );
  }
}
