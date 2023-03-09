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
    this.viewingSong,
    //required this.viewController,
  });

  //final LyricsController viewController;
  final Song? viewingSong;

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
      content: PlayerView(
        appc: appc,
        viewingSong: viewingSong,
      ),
    );
  }
}

class PlayerView extends StatelessWidget {
  const PlayerView({
    super.key,
    required this.appc,
    required this.viewingSong,
  });

  final AppController appc;
  final Song? viewingSong;
  //final LyricsController viewController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(
          viewingSong == null ? const Size(220, 442) : const Size(220, 500)),
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
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: () =>
                    appc.player.seekBy(const Duration(seconds: -10)),
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.replay_10_rounded,
                  color: context.theme.primaryColor,
                ),
              ),
              CupertinoButton(
                onPressed: () => appc.player.previous(),
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.backward_fill,
                  color: context.theme.primaryColor,
                ),
              ),
              StreamBuilder(
                stream: appc.player.playerState,
                builder: (_, AsyncSnapshot<PlayerState> snap) {
                  return CupertinoButton(
                    onPressed: () => appc.player.playOrPause(),
                    padding: const EdgeInsets.only(left: 0),
                    child: Icon(
                      appc.player.isPlaying.value
                          ? CupertinoIcons.pause_solid
                          : CupertinoIcons.play_arrow_solid,
                      color: context.theme.primaryColor,
                      size: 43,
                    ),
                  );
                },
              ),
              CupertinoButton(
                onPressed: () => appc.player.next(stopIfLast: true),
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.forward_fill,
                  color: context.theme.primaryColor,
                ),
              ),
              CupertinoButton(
                onPressed: () => appc.player.seekBy(
                  const Duration(seconds: 10),
                ),
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.forward_10_rounded,
                  color: context.theme.primaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                onPressed: () => appc.player.toggleShuffle(),
                padding: EdgeInsets.zero,
                child: StreamBuilder(
                  stream: appc.player.isShuffling,
                  builder: (_, snapshot) {
                    return Icon(
                      CupertinoIcons.shuffle_medium,
                      color: snapshot.data ?? false
                          ? context.theme.primaryColor
                          : context.theme.cardColor.withAlpha(90),
                    );
                  },
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  switch (appc.player.loopMode.value) {
                    case LoopMode.none:
                      appc.player.setLoopMode(LoopMode.single);
                      break;
                    case LoopMode.single:
                      appc.player.setLoopMode(LoopMode.playlist);
                      break;
                    case LoopMode.playlist:
                      appc.player.setLoopMode(LoopMode.none);
                      break;
                  }
                },
                padding: EdgeInsets.zero,
                child: StreamBuilder(
                  stream: appc.player.loopMode,
                  builder: (_, snapshot) {
                    var mode = snapshot.data ?? LoopMode.none;
                    return Icon(
                      mode == LoopMode.single
                          ? CupertinoIcons.repeat_1
                          : CupertinoIcons.repeat,
                      color: mode == LoopMode.none
                          ? context.theme.cardColor.withAlpha(90)
                          : context.theme.primaryColor,
                    );
                  },
                ),
              ),
            ],
          )
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
        if (appc.player.isPlaying.value) {
          String title = appc.player.getCurrentAudioTitle;
          IsarService isar = Get.find();
          Song? song = await isar.getSongByTitle(title);
          LyricsController lyricsController = Get.find();
          lyricsController.song = song!;
          await Get.offAndToNamed(Routes.LYRICS, arguments: song);
        }
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
