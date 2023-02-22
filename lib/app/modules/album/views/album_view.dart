import 'dart:developer';

import 'package:chasinaidil/app/flutter_rewrite/navbar.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            trailing: controller.album.songBook == SongBook.playlists &&
                    controller.album.albumId != 999999999999999999
                ? CupertinoButton(
                    onPressed: () => Get.dialog(
                      CupertinoAlertDialog(
                        title: const Text('Delete Playlist'),
                        content: const Text(
                            'Shall the playlist be deleted forever?'),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            /// This parameter indicates this action is the default,
                            /// and turns the action's text to bold text.
                            isDefaultAction: true,
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('No'),
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
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                    minSize: 1,
                    padding: EdgeInsets.zero,
                    child: const Icon(CupertinoIcons.delete),
                  )
                : null,
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
                          id: 'playlistUpdate',
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
                        width: context.width / 2,
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
              child: Obx(
                () {
                  List<Widget> list = [];
                  int count = 0;
                  for (var song in controller.songs) {
                    list.add(InkWell(
                      onTap: () => Get.toNamed(Routes.LYRICS, arguments: song),
                      //color: Colors.white,

                      //: kMinInteractiveDimensionCupertino,
                      //width: context.width - 16,

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        height: kMinInteractiveDimensionCupertino,
                        width: context.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 39,
                              child: Text(
                                song.songNumber,
                                //style: const TextStyle(
                                //   color: Colors.black45, fontSize: 15),
                                style: context.theme.textTheme.bodySmall,
                              ),
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
                    ));
                    if (count != controller.songs.length - 1) {
                      list.add(const Divider(
                        thickness: 0.5,
                        indent: 55,
                        endIndent: 6,
                        height: 0.5,
                      ));
                    } else {
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
