import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchResultView extends StatelessWidget {
  SearchResultView({super.key});

  final HomeController _homeController = Get.find();

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
                    style: const TextStyle(color: Colors.black45),
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
                    Get.toNamed('/lyrics', arguments: currentResult);

                    // Save 5 last opened songs
                    final List<dynamic> lastSearches =
                        GetStorage().read(Prefs.listLastSearches) ?? [];
                    lastSearches.remove(currentResult.id);
                    lastSearches.insert(0, currentResult.id);
                    if (lastSearches.length > 5) lastSearches.removeLast();
                    GetStorage().write(Prefs.listLastSearches, lastSearches);
                  },
                  onLongPress: () {
                    Get.snackbar(
                        currentResult.title, "Will be implemented later");
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
                            child: Image.asset(
                              currentResult.coverAsset,
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
                                    currentResult.book,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
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
