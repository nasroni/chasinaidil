import 'dart:developer';
import 'dart:io';

import 'package:al_downloader/al_downloader.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/album/controllers/album_controller.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/controllers/lyrics_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/positionseekwidget.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class PlayerDialog extends StatelessWidget {
  const PlayerDialog({
    super.key,
    this.viewingSong,
    this.isOnHomeScreen = false,
    //required this.viewController,
  });

  //final LyricsController viewController;
  final Song? viewingSong;
  final bool isOnHomeScreen;

  @override
  Widget build(BuildContext context) {
    AppController appc = Get.find();
    //if (appc.player.getCurrentAudioTitle == "") {
    if (appc.jplayer.currentIndex == null) {
      appc.isCurrentlyPlayingView.value = true;
    } else {
      appc.isCurrentlyPlayingView.value = false;
    }
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
        isOnHomescreen: isOnHomeScreen,
      ),
    );
  }
}

class PlayerView extends StatelessWidget {
  const PlayerView({
    super.key,
    required this.appc,
    required this.viewingSong,
    required this.isOnHomescreen,
  });

  final AppController appc;
  final Song? viewingSong;
  final bool isOnHomescreen;
  //final LyricsController viewController = Get.find();

  @override
  Widget build(BuildContext context) {
    ever(appc.isCurrentlyPlayingView, (_) => appc.update(['playerView']));
    return GetBuilder<AppController>(
        id: 'playerView',
        builder: (_) {
          return ConstrainedBox(
            constraints: BoxConstraints.tight(viewingSong == null
                ? const Size(220, 450)
                : const Size(220, 530)),
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
                        '${viewingSong!.songNumber}. ${viewingSong!.title}',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: context.theme.textTheme.displayLarge
                            ?.copyWith(fontSize: 20),
                      )
                    : StreamBuilder(
                        stream: appc.mediaItemStream,
                        builder: (context, snap) {
                          return Text(
                            appc.currentMediaItem?.title ?? "not provided",
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
                        stream: appc.mediaItemStream,
                        builder: (context, snap) {
                          return Text(
                            appc.currentMediaItem?.artist ?? "no title loaded",
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
                  StreamBuilder(
                      stream: appc.jplayer.durationStream,
                      builder: (_, durationstream) {
                        return StreamBuilder(
                          stream: appc.jplayer.positionStream,
                          builder: (_, value) {
                            return PositionSeekWidget(
                              currentPosition: value.data ?? const Duration(),
                              duration: durationstream.data ??
                                  const Duration(minutes: 61),
                              seekTo: (val) => appc.jplayer.seek(val),
                            );
                          },
                        );
                      }),
                if (!appc.isCurrentlyPlayingView.value)
                  const SizedBox(
                    height: 15,
                  ),
                if (!appc.isCurrentlyPlayingView.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          if (appc.jplayer.position >
                              const Duration(seconds: 10)) {
                            appc.jplayer.seek(appc.jplayer.position -
                                const Duration(seconds: 10));
                          } else {
                            appc.jplayer.seek(const Duration(seconds: 0));
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.replay_10_rounded,
                          color: context.theme.primaryColor,
                        ),
                      ),
                      StreamBuilder(
                          stream: appc.jplayer.currentIndexStream,
                          builder: (context, snapshot) {
                            return CupertinoButton(
                              onPressed: appc.jplayer.hasPrevious
                                  ? () {
                                      appc.jplayer.seekToPrevious();
                                      if (!appc.jplayer.playing) {
                                        appc.jplayer.seekToPrevious();
                                      }
                                    }
                                  : null,
                              padding: EdgeInsets.zero,
                              child: Icon(
                                CupertinoIcons.backward_fill,
                                color: context.theme.primaryColor.withAlpha(
                                    appc.jplayer.hasPrevious ? 255 : 100),
                              ),
                            );
                          }),
                      StreamBuilder(
                        stream: appc.jplayer.playingStream,
                        builder: (_, AsyncSnapshot<bool> snap) {
                          return CupertinoButton(
                            onPressed: () => snap.data ?? true
                                ? appc.jplayer.pause()
                                : appc.jplayer.play(),
                            padding: const EdgeInsets.only(left: 0),
                            child: Icon(
                              snap.data ?? true
                                  ? CupertinoIcons.pause_solid
                                  : CupertinoIcons.play_arrow_solid,
                              color: context.theme.primaryColor,
                              size: 43,
                            ),
                          );
                        },
                      ),
                      StreamBuilder(
                          stream: appc.jplayer.currentIndexStream,
                          builder: (context, snapshot) {
                            return CupertinoButton(
                              onPressed: appc.jplayer.hasNext
                                  ? () {
                                      appc.jplayer.seekToNext();
                                      if (!appc.jplayer.playing) {
                                        appc.jplayer.seekToNext();
                                      }
                                    }
                                  : null,
                              padding: EdgeInsets.zero,
                              child: Icon(
                                CupertinoIcons.forward_fill,
                                color: context.theme.primaryColor.withAlpha(
                                    appc.jplayer.hasNext ? 255 : 100),
                              ),
                            );
                          }),
                      CupertinoButton(
                        onPressed: () {
                          int comparison =
                              (appc.jplayer.duration?.inSeconds ?? 3) -
                                  appc.jplayer.position.inSeconds;
                          if (comparison > 10) {
                            appc.jplayer.seek((const Duration(seconds: 10)) +
                                appc.jplayer.position);
                          } else if (appc.jplayer.hasNext) {
                            appc.jplayer.seekToNext();
                          } else {
                            appc.jplayer.seek(appc.jplayer.duration);
                            appc.jplayer.stop();
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.forward_10_rounded,
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                if (!appc.isCurrentlyPlayingView.value)
                  const SizedBox(
                    height: 6,
                  ),
                if (!appc.isCurrentlyPlayingView.value)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        onPressed: () => appc.jplayer.setShuffleModeEnabled(
                          !appc.jplayer.shuffleModeEnabled,
                        ),
                        padding: EdgeInsets.zero,
                        child: StreamBuilder(
                          stream: appc.jplayer.shuffleModeEnabledStream,
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
                      StreamBuilder(
                          stream: appc.jplayer.currentIndexStream,
                          builder: (context, snapshot) {
                            IsarService isar = Get.find();
                            var songId =
                                int.tryParse(appc.currentMediaItem?.id ?? '');
                            Song? playingSong;
                            if (songId != null) {
                              playingSong = isar.getSongByIdSync(songId);
                            }
                            return CupertinoButton(
                              onPressed: () async {
                                if (playingSong == null) return;
                                var playlists = await isar.getAllPlaylists();
                                var favoriteList = playlists
                                    .firstWhere((element) => element.id == 0);
                                if (playingSong.isFavorite) {
                                  await favoriteList.removeSong(playingSong);
                                } else {
                                  await favoriteList.addSong(playingSong,
                                      shallClose: false);
                                  log(favoriteList.songIds.toString());
                                }
                                if (!isOnHomescreen) {
                                  await Get.find<AlbumController>()
                                      .reloadPlaylist();
                                }
                                appc.update(['favoriteInDialog']);
                                appc.update(['updateViews']);
                              },
                              padding: EdgeInsets.zero,
                              child: GetBuilder<AppController>(
                                id: 'favoriteInDialog',
                                builder: (_) => playingSong?.isFavorite ?? false
                                    ? Icon(
                                        Icons.favorite,
                                        color: context.theme.primaryColor,
                                      )
                                    : Icon(
                                        Icons.favorite_border_outlined,
                                        color: context.theme.cardColor
                                            .withAlpha(90),
                                      ),
                              ),
                            );
                          }),
                      CupertinoButton(
                        onPressed: () {
                          switch (appc.jplayer.loopMode) {
                            case LoopMode.off:
                              appc.jplayer.setLoopMode(LoopMode.all);
                              break;
                            case LoopMode.one:
                              appc.jplayer.setLoopMode(LoopMode.off);
                              break;
                            case LoopMode.all:
                              appc.jplayer.setLoopMode(LoopMode.one);
                              break;
                          }
                        },
                        padding: EdgeInsets.zero,
                        child: StreamBuilder(
                          stream: appc.jplayer.loopModeStream,
                          builder: (_, snapshot) {
                            var mode = snapshot.data ?? LoopMode.off;
                            return Icon(
                              mode == LoopMode.one
                                  ? CupertinoIcons.repeat_1
                                  : CupertinoIcons.repeat,
                              color: mode == LoopMode.off
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
                            appc.jplayer.setShuffleModeEnabled(false);
                            appc.placePlaylist(songs,
                                "${viewingSong!.songNumber}. ${viewingSong!.title}");
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
                                "  cароидан",
                              )
                            ],
                          ),
                        );
                      } else if (appc.isDownloadingSingle.value &&
                          appc.currentlyDownloading.contains(viewingSong!.id)) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ALDownloader.cancel(viewingSong!.audioPathOnline);
                            appc.isDownloadingSingle.value = false;
                            appc.currentlyDownloading.remove(viewingSong!.id);

                            appc.update(['updateViews']);
                          },
                          child: Obx(() => SizedBox(
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
                              )),
                        );
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
                                "  боргирӣ кардан",
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
                              if (appc.jplayer.audioSource != null) {
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
              if (appc.jplayer.playing) {
                String? title = appc.currentMediaItem?.title
                    .replaceFirst(RegExp(r'[0-9]+\. '), '');
                IsarService isar = Get.find();
                Song? song = await isar.getSongByTitle(title ?? "nothing");
                try {
                  LyricsController lyricsController = Get.find();
                  lyricsController.song = song!;
                  await Get.offAndToNamed(Routes.LYRICS, arguments: song);
                } catch (e) {
                  Get.toNamed(Routes.LYRICS, arguments: song);
                }
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
        child: StreamBuilder(
            stream: appc.mediaItemStream, //appc.jplayer.playbackEventStream,
            builder: (_, snap) {
              return appc.isCurrentlyPlayingView.value
                  ? PlayerAlbumImage(
                      imagePath: song!.coverAssetHQ,
                    )
                  : PlayerAlbumImage(
                      imagePath: null,
                      image: appc.currentMediaItem?.artUri,
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
    this.image,
  });

  final String? imagePath;
  final Uri? image;

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
          } else if (image != null) {
            return Image.file(File.fromUri(image!));
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
