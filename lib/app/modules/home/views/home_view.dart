import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/views/albumlist.dart';
import 'package:chasinaidil/app/modules/home/views/searchbar.dart';
import 'package:chasinaidil/app/modules/home/views/searchresults.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import './searchappbar.dart';
import 'booktitle.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AppController appc = Get.find();

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);*/

    return Obx(() => Scaffold(
          body: Container(
            color: context.theme.scaffoldBackgroundColor,
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(
                    milliseconds: 230,
                  ),
                  curve: Curves.linear,
                  child: SearchAppBar(
                    size: controller.isSearchActive.value ? 0 : 100,
                  ),
                ),
                MySearchBar(),
                Expanded(
                  child: controller.isSearchActive.value
                      ? SearchResultView()
                      : Container(
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                BookTitle(
                                  changeEventNotifier:
                                      controller.isChasinaiDilOpen,
                                  songBook: SongBook.chasinaidil,
                                ),
                                AlbumList(
                                  songBook: SongBook.chasinaidil,
                                  changeNotifier: controller.isChasinaiDilOpen,
                                ),
                                BookTitle(
                                  changeEventNotifier:
                                      controller.isTshashmaOpen,
                                  songBook: SongBook.tshashma,
                                ),
                                AlbumList(
                                  songBook: SongBook.tshashma,
                                  changeNotifier: controller.isTshashmaOpen,
                                ),
                                /*BookTitle(
                                  changeEventNotifier: controller.isOthersOpen,
                                  songBook: SongBook.others,
                                ),
                                AlbumList(
                                  songBook: SongBook.others,
                                  changeNotifier: controller.isOthersOpen,
                                ),*/
                                BookTitle(
                                  changeEventNotifier:
                                      controller.isPlaylistsOpen,
                                  songBook: SongBook.playlists,
                                ),
                                AlbumList(
                                  songBook: SongBook.playlists,
                                  changeNotifier: controller.isPlaylistsOpen,
                                ),
                                SizedBox(
                                  height: context.height / 10,
                                )
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
