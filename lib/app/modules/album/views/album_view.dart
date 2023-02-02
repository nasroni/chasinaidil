import 'package:chasinaidil/app/flutter_rewrite/navbar.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/album_controller.dart';

class AlbumView extends GetView<AlbumController> {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          MyCupertinoSliverNavigationBar(
            padding: const EdgeInsetsDirectional.only(end: 20),
            middle: Text(controller.album.title),
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
                      child: Image.asset(
                        controller.album.coverPath,
                        height: context.width / 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.album.title,
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text(
                    HomeController.giveBookTitle(controller.album.songBook),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
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
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
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
                        indent: 26,
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
