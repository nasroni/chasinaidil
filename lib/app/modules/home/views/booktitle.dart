import 'dart:math';

import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

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
              () => Icon(
                CupertinoIcons.chevron_right,
                color: context.theme.primaryColor,
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
              style: TextStyle(
                color: context.theme.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            if (songBook != SongBook.playlists)
              CupertinoButton(
                onPressed: () => Get.toNamed(
                  Routes.ALBUM,
                  arguments: Album(
                    'Ҳама',
                    17,
                    Album.genPath(17, SongBook.chasinaidil),
                    SongBook.chasinaidil,
                  ),
                ),
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.list_bullet,
                  color: context.theme.primaryColor,
                  size: 25,
                ),
              ),
          ],
        ),
        onPressed: () => controller.toggleOpenState(songBook),
      ),
    );
  }
}
