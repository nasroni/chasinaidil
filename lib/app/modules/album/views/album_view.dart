import 'package:chasinaidil/app/flutter_rewrite/navbar.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
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
            padding: EdgeInsetsDirectional.only(end: 20),
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
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    HomeController.giveBookTitle(controller.album.songBook),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Material(
                child: Column(
              children: [],
            )),
          )
        ],
      ),
    );
  }
}
