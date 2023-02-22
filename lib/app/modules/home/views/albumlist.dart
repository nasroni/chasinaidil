import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'albumbutton.dart';

class AlbumList extends StatelessWidget {
  AlbumList({super.key, required this.songBook, required this.changeNotifier});

  final HomeController controller = Get.find();
  final SongBook songBook;
  final RxBool changeNotifier;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
