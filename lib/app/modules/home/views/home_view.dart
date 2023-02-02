import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/views/searchresults.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import './searchbar.dart';
import './searchappbar.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AppController appc = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    /*GetPlatform.isAndroid
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
            SystemUiOverlay.top,
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);*/

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
                SearchBar(),
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
                                /*BookTitle(
                                  changeEventNotifier:
                                      controller.isTshashmaOpen,
                                  songBook: SongBook.tshashma,
                                ),
                                AlbumList(
                                  songBook: SongBook.tshashma,
                                  changeNotifier: controller.isTshashmaOpen,
                                ),*/
                                /*BookTitle(
                                  changeEventNotifier: controller.isOthersOpen,
                                  songBook: SongBook.others,
                                ),
                                AlbumList(
                                  songBook: SongBook.others,
                                  changeNotifier: controller.isOthersOpen,
                                ),
                                BookTitle(
                                  changeEventNotifier:
                                      controller.isPlaylistsOpen,
                                  songBook: SongBook.playlists,
                                ),
                                AlbumList(
                                  songBook: SongBook.playlists,
                                  changeNotifier: controller.isPlaylistsOpen,
                                )*/
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

class AlbumList extends StatelessWidget {
  AlbumList({super.key, required this.songBook, required this.changeNotifier});

  final HomeController controller = Get.find();
  final SongBook songBook;
  final RxBool changeNotifier;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        //color: Colors.red,
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 20,
          runSpacing: 15,
          children: Album.list(songBook)
              .map(
                (e) => AlbumButton(
                  album: e,
                ),
              )
              .toList(),
        ),
      )
          .animate(target: changeNotifier.value ? 0 : 1)
          .fadeOut(duration: const Duration(milliseconds: 100))
          .swap(
            //delay: const Duration(milliseconds: 500),
            builder: (_, __) => Container(),
          ),
    );
  }
}

class AlbumButton extends StatelessWidget {
  const AlbumButton({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () =>
          Get.toNamed(Routes.ALBUM, arguments: album), // TODO: implement click
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: (context.width / 3) - 26.7,
        //height: (context.width / 3) - 26.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                album.coverPath,
                height: (context.width / 3) - 26.7,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              album.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class BookTitle extends StatelessWidget {
  BookTitle({
    super.key,
    required this.changeEventNotifier,
    required this.songBook,
  });

  final HomeController controller = Get.find();
  final RxBool changeEventNotifier;
  final SongBook songBook;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: CupertinoButton(
        child: Row(
          children: [
            Obx(
              () => const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.black,
                size: 25,
              )
                  .animate(
                    target: changeEventNotifier.value ? 1 : 0,
                  )
                  .custom(
                    begin: 0,
                    end: pi / 2,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: child,
                      );
                    },
                  ),
            ),
            Text(
              ' ${HomeController.giveBookTitle(songBook)}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        onPressed: () => controller.toggleOpenState(songBook),
      ),
    );
  }
}
