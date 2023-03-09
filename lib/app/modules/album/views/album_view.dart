import 'dart:io';
import 'dart:math';

import 'package:al_downloader/al_downloader.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
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
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../controllers/album_controller.dart';

class AlbumView extends GetView<AlbumController> {
  const AlbumView({Key? key, this.nested = 0}) : super(key: key);

  final int nested;

  @override
  AlbumController get controller {
    if (nested == 0) {
      return super.controller;
    } else {
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
                if (appc.player.current.value != null)
                  CupertinoButton(
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
                  ),
                if (controller.album.songBook == SongBook.playlists &&
                    controller.album.albumId != 999999999999999999)
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
                  Obx(() {
                    if (controller.isTitleEditing.value) {
                      return SizedBox(
                        width: context.width,
                        child: CupertinoTextField.borderless(
                          placeholder: controller.album.playlist?.name,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          onSubmitted: (val) => controller.setNewName(val),
                          style: context.theme.textTheme.displayLarge,
                        ),
                      );
                    } else if (controller.album.songBook ==
                        SongBook.playlists) {
                      return GestureDetector(
                        onTap: () {
                          controller.isTitleEditing.value = true;
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
                  }),
                  Text(
                    HomeController.giveBookTitle(controller.album.songBook),
                    style: context.theme.textTheme.displayMedium,
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
                                  !(appc.isDownloading.value &&
                                      controller.isFirstDownload.value))
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: CupertinoButton(
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
                                      appc.player.shuffle = false;
                                      appc.placePlaylist(songs, null);
                                    },
                                    color: context.theme.secondaryHeaderColor,
                                    padding: const EdgeInsets.all(11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          CupertinoIcons.play_arrow_solid,
                                          size: 20,
                                        ),
                                        Text(' Play'),
                                      ],
                                    ),
                                  ),
                                ),
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloading.value &&
                                      controller.isFirstDownload.value))
                                const SizedBox(
                                  width: 10,
                                ),
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloading.value &&
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
                                      appc.player.shuffle = true;
                                      appc.player.setLoopMode(LoopMode.none);
                                      String titleStartSong =
                                          songs[Random().nextInt(songs.length)]
                                              .title;
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
                                        Text('  Shuffle'),
                                      ],
                                    ),
                                  ),
                                ),
                              if (!controller.isNothingDownloaded &&
                                  !(appc.isDownloading.value &&
                                      controller.isFirstDownload.value))
                                const SizedBox(
                                  width: 10,
                                ),
                              if (!controller.isEverythingDownloaded)
                                Expanded(
                                  child: appc.isDownloading.value
                                      ? SizedBox(
                                          height: 44,
                                          child: LiquidLinearProgressIndicator(
                                            backgroundColor: context
                                                .theme.scaffoldBackgroundColor,
                                            borderRadius: 4,
                                            value:
                                                appc.downloadPercentage.value /
                                                    100,
                                            valueColor: AlwaysStoppedAnimation(
                                              context
                                                  .theme.secondaryHeaderColor,
                                            ),
                                            center: Text(
                                              "${appc.downloadPercentage.value.round()} %",
                                              style: context
                                                  .theme.textTheme.bodyLarge,
                                            ),
                                          ),
                                        )
                                      : CupertinoButton(
                                          color: context
                                              .theme.secondaryHeaderColor,
                                          disabledColor: Colors.grey.shade500,
                                          onPressed: () async {
                                            List<Song> songsToDownload;
                                            if (controller.album.albumId ==
                                                    17 &&
                                                controller.album.songBook ==
                                                    SongBook.chasinaidil) {
                                              songsToDownload = await appc
                                                  .getAllDownloadedSongsFromBook(
                                                      SongBook.chasinaidil,
                                                      true);
                                            } else if (controller
                                                    .album.songBook ==
                                                SongBook.playlists) {
                                              songsToDownload = await appc
                                                  .getAllDownloadedSongsFromPlaylist(
                                                      controller
                                                          .album.playlist!,
                                                      true);
                                            } else {
                                              songsToDownload = await appc
                                                  .getAllDownloadedSongsFromAlbum(
                                                      controller.album, true);
                                            }

                                            appc.downloadList(songsToDownload);
                                            if (controller
                                                .isNothingDownloaded) {
                                              controller.isFirstDownload.value =
                                                  true;
                                            }
                                          },
                                          padding: const EdgeInsets.all(11),
                                          child: const Icon(
                                            Icons.download,
                                            size: 20,
                                          ),
                                        ),
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
                              background: Container(color: Colors.red),
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
                                          Get.back(result: true);
                                        },
                                        child: const Text('Бале'),
                                      ),
                                    ],
                                  ));
                                } else {
                                  return Get.dialog(CupertinoAlertDialog(
                                    title: const Text('Delete audio az суруд'),
                                    content: Text(
                                      "Ҳақиқатан audioi суруди \"${song.title}\"-ро аз telefon дур кардан мехоҳӣ?",
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
                                            width: 39,
                                            child: Text(
                                              song.songNumber,
                                              //style: const TextStyle(
                                              //   color: Colors.black45, fontSize: 15),
                                              style: context
                                                  .theme.textTheme.bodySmall,
                                            ),
                                          ),
                                          if (song.isDownloaded)
                                            const Icon(
                                              Icons.download_done,
                                              color: Colors.green,
                                            ),
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
