import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/positionseekwidget.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
    if (!appc.player.current.hasValue) appc.isCurrentlyPlayingView.value = true;
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
      scrollable: true,

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
    ever(appc.isCurrentlyPlayingView, (_) => appc.update(['playerView']));
    return GetBuilder<AppController>(
        id: 'playerView',
        builder: (_) {
          return ConstrainedBox(
            constraints: BoxConstraints.tight(viewingSong == null
                ? const Size(220, 442)
                : const Size(220, 520)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerAlbumImageWithBox(
                  appc: appc,
                  song: viewingSong,
                ),
                const SizedBox(
                  height: 20,
                ),
                appc.isCurrentlyPlayingView.value
                    ? Text(
                        viewingSong!.title,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: context.theme.textTheme.displayLarge
                            ?.copyWith(fontSize: 20),
                      )
                    : StreamBuilder(
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
                appc.isCurrentlyPlayingView.value
                    ? Text(
                        viewingSong!.book,
                        textAlign: TextAlign.left,
                        style: context.theme.textTheme.displayMedium
                            ?.copyWith(fontSize: 15, color: Colors.grey),
                      )
                    : StreamBuilder(
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
                if (!appc.isCurrentlyPlayingView.value)
                  appc.player.builderRealtimePlayingInfos(
                    builder: (context, RealtimePlayingInfos infos) {
                      return PositionSeekWidget(
                        currentPosition: infos.currentPosition,
                        duration: infos.duration,
                        seekTo: (val) => appc.player.seek(val),
                      );
                    },
                  ),
                if (!appc.isCurrentlyPlayingView.value)
                  const SizedBox(
                    height: 15,
                  ),
                if (!appc.isCurrentlyPlayingView.value)
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
                if (!appc.isCurrentlyPlayingView.value)
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
                  ),
                if (appc.isCurrentlyPlayingView.value)
                  GetBuilder<AppController>(
                    id: 'updateViews',
                    builder: (_) {
                      if (viewingSong!.isDownloaded) {
                        return CupertinoButton(
                          onPressed: () async {
                            var songBook = HomeController.giveSongBookEnum(
                                viewingSong!.book);
                            var songs = await appc
                                .getAllDownloadedSongsFromBook(songBook, false);
                            appc.placePlaylist(songs, viewingSong!.title);
                            appc.isCurrentlyPlayingView.value = false;
                          },
                          color: context.theme.secondaryHeaderColor,
                          padding: const EdgeInsets.all(11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.play_fill,
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              const Text(
                                "  Play   ",
                              )
                            ],
                          ),
                        );
                      } else if (appc.isDownloadingSingle.value) {
                        return Obx(() => SizedBox(
                              height: 44,
                              child: LiquidLinearProgressIndicator(
                                backgroundColor:
                                    context.theme.scaffoldBackgroundColor,
                                borderRadius: 4,
                                value:
                                    appc.downloadPercentageSingle.value / 100,
                                valueColor: AlwaysStoppedAnimation(
                                  context.theme.secondaryHeaderColor,
                                ),
                                center: Text(
                                  "${appc.downloadPercentageSingle.value.round()} %",
                                  style: context.theme.textTheme.bodyLarge,
                                ),
                              ),
                            ));
                      } else {
                        return CupertinoButton(
                          onPressed: () => appc.downloadSong(viewingSong!),
                          color: context.theme.secondaryHeaderColor,
                          padding: const EdgeInsets.all(11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download,
                                color: context.theme.scaffoldBackgroundColor,
                              ),
                              const Text(
                                "  Download   ",
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                const Spacer(),
                if (viewingSong != null)
                  const Divider(
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                    thickness: 0.7,
                  ),
                if (viewingSong != null)
                  const SizedBox(
                    height: 10,
                  ),
                if (viewingSong != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${viewingSong!.songNumber}. ${viewingSong!.title}',
                          style: context.theme.textTheme.displayMedium
                              ?.copyWith(fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Obx(
                        () => CupertinoSwitch(
                            value: appc.isCurrentlyPlayingView.value,
                            onChanged: (_) {
                              if (appc.player.current.hasValue) {
                                appc.isCurrentlyPlayingView.value =
                                    !appc.isCurrentlyPlayingView.value;
                              }
                            }),
                      ),
                    ],
                  )
              ],
            ),
          );
        });
  }
}

class PlayerAlbumImageWithBox extends StatelessWidget {
  const PlayerAlbumImageWithBox({
    super.key,
    required this.appc,
    this.song,
  });

  final AppController appc;
  final Song? song;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: appc.isCurrentlyPlayingView.value
          ? null
          : () async {
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
            imagePath: appc.isCurrentlyPlayingView.value
                ? song!.coverAssetHQ
                : appc.player.getCurrentAudioImage?.path,
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
