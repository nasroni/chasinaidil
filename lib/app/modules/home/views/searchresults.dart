import 'package:al_downloader/al_downloader.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/popupcustommenuitem.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchResultView extends StatelessWidget {
  SearchResultView({super.key});

  final HomeController _homeController = Get.find();
  final AppController appc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.5,
            indent: 6,
            endIndent: 6,
            height: 0.5,
          );
        },
        padding: const EdgeInsets.all(0),
        itemCount: _homeController.searchResults.length,
        itemBuilder: ((context, index) {
          final currentResult = _homeController.searchResults[index];
          Widget infoItem = Container();

          if (_homeController.searchResultLyricsBeginPosition.value == index ||
              (_homeController.isShowingLastSearched.value && index == 0)) {
            infoItem = Column(
              children: [
                index == 0
                    ? Container()
                    : Divider(
                        indent: context.width / 4.5,
                        endIndent: context.width / 4.5,
                        thickness: 2,
                      ),
                Container(
                  //color: Colors.black12,
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 8),
                  child: Text(
                    _homeController.isShowingLastSearched.value
                        ? "Ҷустуҷӯи охирин"
                        : "Дар матн",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: context.theme.cardColor),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              infoItem,
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.LYRICS, arguments: currentResult);

                    // Save 5 last opened songs
                    final List<dynamic> lastSearches =
                        GetStorage().read(Prefs.listLastSearches) ?? [];
                    lastSearches.remove(currentResult.id);
                    lastSearches.insert(0, currentResult.id);
                    if (lastSearches.length > 5) lastSearches.removeLast();
                    GetStorage().write(Prefs.listLastSearches, lastSearches);
                  },
                  onLongPress: () {
                    Get.dialog(AlertDialog(
                      alignment: Alignment.center,
                      //insetPadding:
                      //    const EdgeInsets.only(top: 55, right: 10, left: 10),
                      elevation: 30,
                      actionsPadding: EdgeInsets.zero,
                      buttonPadding: EdgeInsets.zero,
                      //contentPadding: EdgeInsets.zero,
                      titlePadding: EdgeInsets.zero,
                      iconPadding: EdgeInsets.zero,
                      backgroundColor: context.theme.dialogBackgroundColor,
                      contentPadding: EdgeInsets.zero,
                      scrollable: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      content: GetBuilder<AppController>(
                          id: 'updateViews',
                          builder: (_) {
                            return Column(
                              children: [
                                if (appc.currentlyDownloading
                                    .contains(currentResult.id))
                                  TextButton(
                                    onPressed: () {
                                      ALDownloader.cancel(
                                          currentResult.audioPathOnline);
                                      appc.isDownloadingSingle.value = false;
                                      appc.currentlyDownloading
                                          .remove(currentResult.id);
                                      appc.update(['updateViews']);
                                    },
                                    style:
                                        PopupCustomMenuItem.buttonMyCustomStyle(
                                                1, context)
                                            .copyWith(
                                      minimumSize:
                                          const MaterialStatePropertyAll(
                                        Size.fromHeight(50),
                                      ),
                                    ),
                                    child: Container(
                                      height: kMinInteractiveDimensionCupertino,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // name of item / action, that is current line and button
                                            '... боргирифтан ...',
                                            style: TextStyle(
                                              color: context.theme.primaryColor,
                                              // mark for example when currently selected mode is
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          // optical explanation of 'text'
                                          Icon(
                                            Icons.downloading_rounded,
                                            color: context.theme.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (!currentResult.isDownloaded &&
                                    !appc.currentlyDownloading
                                        .contains(currentResult.id))
                                  TextButton(
                                    onPressed: () async {
                                      appc.downloadSong(currentResult);
                                    },
                                    style: PopupCustomMenuItem
                                            .buttonMyCustomStyle(1, context)
                                        .copyWith(
                                            minimumSize:
                                                const MaterialStatePropertyAll(
                                                    Size.fromHeight(50))),
                                    child: Container(
                                      height: kMinInteractiveDimensionCupertino,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // name of item / action, that is current line and button
                                            'боргирӣ кардан',
                                            style: TextStyle(
                                              color: context.theme.primaryColor,
                                              // mark for example when currently selected mode is
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          // optical explanation of 'text'
                                          Icon(
                                            Icons.download,
                                            color: context.theme.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (currentResult.isDownloaded)
                                  TextButton(
                                    onPressed: () async {
                                      AppController appc = Get.find();
                                      var songBook =
                                          HomeController.giveSongBookEnum(
                                              currentResult.book);
                                      var songs = await appc
                                          .getAllDownloadedSongsFromBook(
                                              songBook, false);
                                      appc.jplayer.setShuffleModeEnabled(false);
                                      appc.placePlaylist(songs,
                                          "${currentResult.songNumber}. ${currentResult.title}");
                                      Get.back();
                                    },
                                    style: PopupCustomMenuItem
                                            .buttonMyCustomStyle(1, context)
                                        .copyWith(
                                            minimumSize:
                                                const MaterialStatePropertyAll(
                                                    Size.fromHeight(50))),
                                    child: Container(
                                      height: kMinInteractiveDimensionCupertino,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // name of item / action, that is current line and button
                                            'cароидан',
                                            style: TextStyle(
                                              color: context.theme.primaryColor,
                                              // mark for example when currently selected mode is
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          // optical explanation of 'text'
                                          Icon(
                                            CupertinoIcons.play_arrow_solid,
                                            color: context.theme.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                TextButton(
                                  onPressed: () => Get.find<AppController>()
                                      .playlistDialog(currentResult),
                                  style: PopupCustomMenuItem
                                          .buttonMyCustomStyle(-1, context)
                                      .copyWith(
                                          minimumSize:
                                              const MaterialStatePropertyAll(
                                                  Size.fromHeight(50))),
                                  child: Container(
                                    height: kMinInteractiveDimensionCupertino,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // name of item / action, that is current line and button
                                          'Ворид ба плейлист',
                                          style: TextStyle(
                                            color: context.theme.primaryColor,
                                            // mark for example when currently selected mode is
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        // optical explanation of 'text'
                                        Icon(
                                          Icons.playlist_add,
                                          color: context.theme.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ));
                  },
                  enableFeedback: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Row(
                      children: [
                        Container(
                          height: 55,
                          padding: const EdgeInsets.fromLTRB(6, 4, 12, 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.asset(
                                  currentResult.coverAsset,
                                ),
                                Positioned.fill(
                                  child: Opacity(
                                    opacity: Get.isDarkMode ? 0.1 : 0,
                                    child: Container(
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${currentResult.songNumber}・",
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        currentResult.title,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    currentResult.bookCyr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: context.theme.cardColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
