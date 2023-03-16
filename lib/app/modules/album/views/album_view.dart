import 'dart:io';
import 'dart:math';

import 'package:al_downloader/al_downloader.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/flutter_rewrite/navbar.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/playerdialog.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../controllers/album_controller.dart';
import 'exchangedialog.dart';

class AlbumView extends GetView<AlbumController> {
  const AlbumView({
    Key? key,
    this.nested = 0,
  }) : super(key: key);

  final int nested;
  //final AlbumController? otherController;

  @override
  AlbumController get controller {
    if (nested == 0) {
      return super.controller;
    } else {
      //return otherController!;
      return Get.find<AlbumController>(tag: nested.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    AppController appc = Get.find();
    var savedContext = context;
    if (controller.album.albumId == 999999999999999999) {
      controller.isTitleEditing.value = true;
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MyCupertinoSliverNavigationBar(
            backgroundColor: context.theme.shadowColor,
            padding: const EdgeInsetsDirectional.only(end: 20),
            middle: Text(
              controller.album.title,
              style: context.theme.textTheme.displaySmall,
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () => Get.dialog(ExchangeDialog(
                    album: controller.album,
                  )),
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: Icon(
                    CupertinoIcons.arrow_right_arrow_left,
                    color: CupertinoColors.activeBlue.withAlpha(140),

                    // color: context.theme.primaryColor.withAlpha(150),
                  ),
                ),
                // audio player openn button
                StreamBuilder(
                  stream: appc.jplayer.playerStateStream,
                  builder: (_, __) {
                    if (appc.jplayer.currentIndex != null) {
                      return CupertinoButton(
                        onPressed: () => Get.dialog(
                            const PlayerDialog(
                              viewingSong: null,
                            ),
                            barrierColor: Colors.transparent,
                            barrierDismissible: true),
                        padding: EdgeInsets.zero,
                        minSize: kMinInteractiveDimensionCupertino,
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          CupertinoIcons.playpause,
                          //color: context.theme.primaryColor,
                          size: 24,
                        ),
                      );
                    }
                    return Container();
                  },
                ),

                if (controller.album.songBook == SongBook.playlists &&
                    controller.album.albumId != 999999999999999999 &&
                    controller.album.albumId != 700000)
                  CupertinoButton(
                    onPressed: () => Get.dialog(
                      CupertinoAlertDialog(
                        title: const Text('Дур кардан'),
                        content:
                            const Text('Ҳақиқатан пурра нобуд карда шавад?'),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            /// This parameter indicates this action is the default,
                            /// and turns the action's text to bold text.
                            isDefaultAction: true,
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Не'),
                          ),
                          CupertinoDialogAction(
                            /// This parameter indicates the action would perform
                            /// a destructive action such as deletion, and turns
                            /// the action's text color to red.
                            isDestructiveAction: true,
                            onPressed: () {
                              Get.back();
                              controller.deletePlaylist();
                            },
                            child: const Text('Бале'),
                          ),
                        ],
                      ),
                    ),
                    minSize: 1,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(CupertinoIcons.delete),
                  )
              ],
            ),
            alwaysShowMiddle: false,
            stretch: true,
            largeTitle: Container(
              width: context.width - 32,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Material(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: GetBuilder<AppController>(
                          id: 'updateViews',
                          builder: (context) {
                            return Stack(
                              children: [
                                if (controller.album.songBook ==
                                    SongBook.playlists)
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                if (controller.album.songBook ==
                                    SongBook.playlists)
                                  Container(
                                    height: savedContext.width / 2,
                                    width: savedContext.width / 2,
                                    color: controller.album.playlist?.colorBack,
                                  )
                                else
                                  Image.asset(
                                    controller.album.coverPath,
                                    height: savedContext.width / 2,
                                  ),
                                if (controller.album.songBook ==
                                    SongBook.playlists)
                                  Positioned.fill(
                                    child: Center(
                                      child: Icon(
                                        controller.album.albumId ==
                                                999999999999999999
                                            ? Icons.add
                                            : controller.album.albumId == 700000
                                                ? Icons.favorite_border_outlined
                                                : Icons.playlist_add_check,
                                        //color: HexColor(colorFore),
                                        color: controller
                                            .album.playlist?.colorFore,
                                        size: 80,
                                      ),
                                    ),
                                  ),
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () => controller.setNewColor(),
                                    child: Opacity(
                                      opacity: Get.isDarkMode ? 0.2 : 0,
                                      child: Container(
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<AppController>(
                    id: 'nameEdit',
                    builder: (_) {
                      if (controller.isTitleEditing.value) {
                        return SizedBox(
                          width: context.width,
                          child: CupertinoTextField.borderless(
                            placeholder: controller.album.playlist?.name,
                            placeholderStyle:
                                context.theme.textTheme.displayLarge?.copyWith(
                                    color: context.theme.primaryColor
                                        .withAlpha(50)),
                            padding: EdgeInsets.zero,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            onChanged: (val) =>
                                controller.setNewName(val, keepEditing: true),
                            onSubmitted: (val) => controller.setNewName(val),
                            style: context.theme.textTheme.displayLarge,
                          ),
                        );
                      } else if (controller.album.songBook ==
                              SongBook.playlists &&
                          controller.album.albumId != 700000) {
                        return GestureDetector(
                          onTapDown: (_) {
                            controller.isTitleEditing.value = true;
                            appc.update(['nameEdit']);
                          },
                          child: Text(
                            controller.album.playlist?.name ?? "",
                            style: context.theme.textTheme.displayLarge,
                          ),
                        );
                      } else {
                        return Text(
                          controller.album.title,
                          style: context.theme.textTheme.displayLarge,
                        );
                      }
                    },
                  ),
                  if (controller.album.songBook != SongBook.playlists)
                    Text(
                      HomeController.giveBookTitle(controller.album.songBook),
                      style: context.theme.textTheme.displayMedium,
                    ),
                  if (controller.album.songBook == SongBook.playlists)
                    const SizedBox(
                      height: 20,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<AppController>(
                      id: 'updateViews',
                      builder: (_) {
                        return Container(
                          width: context.width,
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloadingMultiple.value &&
                                      controller.isFirstDownload.value))
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: PlayButton(
                                      controller: controller, appc: appc),
                                ),
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloadingMultiple.value &&
                                      controller.isFirstDownload.value))
                                const SizedBox(
                                  width: 10,
                                ),
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloadingMultiple.value &&
                                      controller.isFirstDownload.value))
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: CupertinoButton(
                                    color: context.theme.secondaryHeaderColor,
                                    onPressed: () async {
                                      List<Song> songs;
                                      if (controller.album.albumId == 17 &&
                                          controller.album.songBook ==
                                              SongBook.chasinaidil) {
                                        songs = await appc
                                            .getAllDownloadedSongsFromBook(
                                                SongBook.chasinaidil, false);
                                      } else if (controller.album.songBook ==
                                          SongBook.playlists) {
                                        songs = await appc
                                            .getAllDownloadedSongsFromPlaylist(
                                                controller.album.playlist!,
                                                false);
                                      } else {
                                        songs = await appc
                                            .getAllDownloadedSongsFromAlbum(
                                                controller.album, false);
                                      }

                                      appc.jplayer.setShuffleModeEnabled(true);
                                      appc.jplayer.setLoopMode(LoopMode.off);

                                      int randomSongNr =
                                          Random().nextInt(songs.length);
                                      Song randomSong = songs[randomSongNr];
                                      String titleStartSong =
                                          "${randomSong.songNumber}. ${randomSong.title}";
                                      appc.placePlaylist(songs, titleStartSong);
                                    },
                                    padding: const EdgeInsets.all(11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          CupertinoIcons.shuffle,
                                          size: 20,
                                        ),
                                        Text('  бетартиб'),
                                      ],
                                    ),
                                  ),
                                ),
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloadingMultiple.value &&
                                      controller.isFirstDownload.value))
                                const SizedBox(
                                  width: 10,
                                ),
                              if (!controller.isEverythingDownloaded)
                                Expanded(
                                  child: appc.isDownloadingMultiple.value &&
                                          (appc.idCurrentlyDLMultiple.value ==
                                                  controller.album.albumId
                                                      .toString() &&
                                              appc.songBookCurrentlyDLMultiple ==
                                                  controller.album.songBook)
                                      ? SizedBox(
                                          height: 44,
                                          child: CupertinoButton(
                                            onPressed: () {
                                              Get.dialog(CupertinoAlertDialog(
                                                title:
                                                    const Text('Қатъ кардан'),
                                                content: const Text(
                                                    'Ҳақиқатан боргириро қатъ кардан мехоҳӣ?'),
                                                actions: <
                                                    CupertinoDialogAction>[
                                                  CupertinoDialogAction(
                                                    /// This parameter indicates this action is the default,
                                                    /// and turns the action's text to bold text.
                                                    isDefaultAction: true,
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: const Text('Не'),
                                                  ),
                                                  CupertinoDialogAction(
                                                    /// This parameter indicates the action would perform
                                                    /// a destructive action such as deletion, and turns
                                                    /// the action's text color to red.
                                                    isDestructiveAction: true,
                                                    onPressed: () {
                                                      Get.back();
                                                      ALDownloader.cancelAll();
                                                      appc.isDownloadingMultiple
                                                          .value = false;
                                                      appc.idCurrentlyDLMultiple
                                                          .value = "";
                                                      appc.currentlyDownloading
                                                          .clear();
                                                      appc.update(
                                                          ['updateViews']);
                                                    },
                                                    child: const Text('Бале'),
                                                  ),
                                                ],
                                              ));
                                            },
                                            padding: EdgeInsets.zero,
                                            child: Obx(
                                              () =>
                                                  LiquidLinearProgressIndicator(
                                                backgroundColor: context.theme
                                                    .scaffoldBackgroundColor,
                                                borderRadius: 4,
                                                value: appc
                                                        .downloadPercentageMultiple
                                                        .value /
                                                    100,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  context.theme
                                                      .secondaryHeaderColor,
                                                ),
                                                center: Text(
                                                  "${appc.downloadPercentageMultiple.value.round()} %",
                                                  style: context.theme.textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : DownloadListButton(
                                          appc: appc, controller: controller),
                                ),
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Material(
              color: context.theme.scaffoldBackgroundColor,
              child: GetBuilder<AppController>(
                  id: 'updateViews',
                  builder: (_) {
                    return Obx(
                      () {
                        List<Widget> list = [];
                        int count = 0;
                        for (var song in controller.songs) {
                          list.add(
                            Dismissible(
                              key: Key(song.id.toString()),
                              background: Container(
                                color: Colors.red,
                                child: Row(
                                  children: const [
                                    Spacer(),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                              direction: (controller.album.songBook ==
                                          SongBook.playlists) ||
                                      (song.isDownloaded)
                                  ? DismissDirection.endToStart
                                  : DismissDirection.none,
                              confirmDismiss: (_) {
                                if (controller.album.songBook ==
                                    SongBook.playlists) {
                                  return Get.dialog(CupertinoAlertDialog(
                                    title: const Text('Берункунии суруд'),
                                    content: Text(
                                      "Ҳақиқатан суруди \"${song.title}\"-ро аз плейлист дур кардан мехоҳӣ?",
                                    ), //
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('Не'),
                                        onPressed: () => Get.back(),
                                      ),
                                      CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          controller.album.playlist
                                              ?.removeSong(song);
                                          controller.reloadPlaylist();
                                          Get.back(result: true);
                                        },
                                        child: const Text('Бале'),
                                      ),
                                    ],
                                  ));
                                } else {
                                  return Get.dialog(CupertinoAlertDialog(
                                    title:
                                        const Text('Дуркунии аудио аз суруд'),
                                    content: Text(
                                      "Ҳақиқатаб суруди \"${song.title}\"-ро аз телефон дур кардан мехоҳӣ?",
                                    ), //
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('Не'),
                                        onPressed: () => Get.back(),
                                      ),
                                      CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        onPressed: () async {
                                          GetStorage()
                                              .remove(song.id.toString());
                                          File(await song.audioPathLocal)
                                              .deleteSync();
                                          try {
                                            ALDownloader.remove(
                                                song.audioPathOnline);
                                          } catch (_) {}

                                          appc.update(['updateViews']);
                                          Get.back();
                                          /*song.audioPathLocal.then(
                                              (value) => File(value).delete());*/
                                        },
                                        child: const Text('Бале'),
                                      ),
                                    ],
                                  ));
                                }
                              },
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(Routes.LYRICS,
                                        arguments: song),
                                    onLongPress: () => Get.find<AppController>()
                                        .playlistDialog(song),
                                    //color: Colors.white,

                                    //: kMinInteractiveDimensionCupertino,
                                    //width: context.width - 16,

                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      height: kMinInteractiveDimensionCupertino,
                                      width: context.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 34,
                                            child: Text(
                                              song.songNumber,
                                              //style: const TextStyle(
                                              //   color: Colors.black45, fontSize: 15),
                                              style: context
                                                  .theme.textTheme.bodySmall,
                                            ),
                                          ),
                                          if (!song.isDownloaded &&
                                              !appc.currentlyDownloading
                                                  .contains(song.id) &&
                                              song.hasRecording)
                                            CupertinoButton(
                                              onPressed: () =>
                                                  appc.downloadSong(song),
                                              padding: EdgeInsets.zero,
                                              minSize: 0,
                                              child: Icon(
                                                Icons.download,
                                                color: context
                                                    .theme.primaryColor
                                                    .withAlpha(150),
                                              ),
                                            ),
                                          if (appc.currentlyDownloading
                                              .contains(song.id))
                                            CupertinoButton(
                                              onPressed: () {
                                                ALDownloader.cancel(
                                                    song.audioPathOnline);
                                                appc.isDownloadingSingle.value =
                                                    false;
                                                appc.currentlyDownloading
                                                    .remove(song.id);
                                                appc.update(['updateViews']);
                                              },
                                              padding: EdgeInsets.zero,
                                              minSize: 0,
                                              child: Icon(
                                                Icons.downloading,
                                                color: context
                                                    .theme.primaryColor
                                                    .withAlpha(150),
                                              ),
                                            ),
                                          if (song.isDownloaded)
                                            CupertinoButton(
                                              onPressed: () async {
                                                var songs;

                                                if (controller.album.songBook !=
                                                    SongBook.playlists) {
                                                  songs = await appc
                                                      .getAllDownloadedSongsFromAlbum(
                                                          controller.album,
                                                          false);
                                                } else {
                                                  songs = await appc
                                                      .getAllDownloadedSongsFromPlaylist(
                                                          controller
                                                              .album.playlist!,
                                                          false);
                                                }

                                                appc.placePlaylist(songs,
                                                    "${song.songNumber}. ${song.title}");
                                                appc.isCurrentlyPlayingView
                                                    .value = false;
                                              },
                                              padding: EdgeInsets.zero,
                                              minSize: 0,
                                              child: Icon(
                                                CupertinoIcons.play_arrow_solid,
                                                color: context
                                                    .theme.primaryColor
                                                    .withAlpha(150),
                                              ),
                                            ),
                                          if (!song.isDownloaded)
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          if (!song.hasRecording)
                                            const Icon(
                                                Icons.music_off_outlined),
                                          if (song.isDownloaded)
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          Expanded(
                                            child: Text(
                                              song.title,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (count != controller.songs.length - 1)
                                    const Divider(
                                      thickness: 0.5,
                                      indent: 55,
                                      endIndent: 6,
                                      height: 0.5,
                                    )
                                ],
                              ),
                            ),
                          );

                          if (count == controller.songs.length - 1) {
                            list.add(SizedBox(
                              height: context.height / 10,
                            ));
                          }
                          count++;
                        }
                        return Column(
                          children: list,
                        );
                      },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class DownloadListButton extends StatelessWidget {
  const DownloadListButton({
    super.key,
    required this.appc,
    required this.controller,
  });

  final AppController appc;
  final AlbumController controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: context.theme.secondaryHeaderColor,
      disabledColor: Colors.grey.shade500,
      onPressed: appc.idCurrentlyDLMultiple.value != ""
          ? null
          : () async {
              List<Song> songsToDownload;

              if (controller.album.albumId == 17 &&
                  controller.album.songBook == SongBook.chasinaidil) {
                //d.log("hello");

                bool? shallProceed = await Get.dialog(CupertinoAlertDialog(
                  title: const Text('боргирӣ кардан'),
                  content: const Text(
                      'Ҳақиқатан тамоми сурудҳои Хазинаи Дилро боргирӣ кардан мехоҳӣ? (зиёда аз 1GB)'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      /// This parameter indicates this action is the default,
                      /// and turns the action's text to bold text.
                      isDefaultAction: false,
                      isDestructiveAction: true,
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: const Text('Не'),
                    ),
                    CupertinoDialogAction(
                      /// This parameter indicates the action would perform
                      /// a destructive action such as deletion, and turns
                      /// the action's text color to red.
                      isDefaultAction: true,
                      isDestructiveAction: false,
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: const Text('Бале'),
                    ),
                  ],
                ));
                if (shallProceed == null || shallProceed == false) {
                  return;
                }

                songsToDownload = await appc.getAllDownloadedSongsFromBook(
                    SongBook.chasinaidil, true);
              } else if (controller.album.songBook == SongBook.playlists) {
                songsToDownload = await appc.getAllDownloadedSongsFromPlaylist(
                    controller.album.playlist!, true);
              } else {
                songsToDownload = await appc.getAllDownloadedSongsFromAlbum(
                    controller.album, true);
              }

              appc.downloadList(songsToDownload);
              appc.idCurrentlyDLMultiple.value =
                  controller.album.albumId.toString();
              appc.songBookCurrentlyDLMultiple = controller.album.songBook;

              if (controller.isNothingDownloaded) {
                controller.isFirstDownload.value = true;
                ever(appc.idCurrentlyDLMultiple, (callback) {
                  if (callback == "") {
                    controller.isFirstDownload.value = false;
                    Get.find<AppController>().update(['updateViews']);
                  }
                });
              }
            },
      padding: const EdgeInsets.all(11),
      child: const Icon(
        Icons.download,
        size: 20,
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.controller,
    required this.appc,
  });

  final AlbumController controller;
  final AppController appc;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        List<Song> songs;
        if (controller.album.albumId == 17 &&
            controller.album.songBook == SongBook.chasinaidil) {
          songs = await appc.getAllDownloadedSongsFromBook(
              SongBook.chasinaidil, false);
        } else if (controller.album.songBook == SongBook.playlists) {
          songs = await appc.getAllDownloadedSongsFromPlaylist(
              controller.album.playlist!, false);
        } else {
          songs = await appc.getAllDownloadedSongsFromAlbum(
              controller.album, false);
        }
        appc.jplayer.setShuffleModeEnabled(false);
        appc.placePlaylist(songs, null);
      },
      color: context.theme.secondaryHeaderColor,
      padding: const EdgeInsets.all(11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            CupertinoIcons.play_arrow_solid,
            size: 20,
          ),
          Text(' cароидан'),
        ],
      ),
    );
  }
}
