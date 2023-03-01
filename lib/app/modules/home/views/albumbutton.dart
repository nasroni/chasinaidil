import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumButton extends StatelessWidget {
  const AlbumButton({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => Get.toNamed(Routes.ALBUM, arguments: album),
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: (context.width / 3) - 26.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: GetBuilder<AppController>(
                  id: 'updatePlaylist',
                  builder: (_) {
                    return Stack(
                      children: [
                        if (album.songBook == SongBook.playlists)
                          Positioned.fill(
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        if (album.songBook != SongBook.playlists)
                          Image.asset(
                            album.coverPath,
                            height: (context.width / 3) - 26.7,
                          )
                        else
                          Container(
                            height: (context.width / 3) - 26.7,
                            width: (context.width / 3) - 26.7,
                            color: album.playlist?.colorBack,
                          ),
                        if (album.songBook == SongBook.playlists)
                          Positioned.fill(
                            child: Center(
                              child: Icon(
                                album.albumId == 999999999999999999
                                    ? Icons.add
                                    : Icons.playlist_add_check,
                                //color: HexColor(colorFore),
                                color: album.playlist?.colorFore,
                                size: 30,
                              ),
                            ),
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
                    );
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            GetBuilder<AppController>(
                id: 'updatePlaylist',
                builder: (ctx) {
                  return Text(
                    album.songBook == SongBook.playlists
                        ? album.playlist?.name ?? ""
                        : album.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(fontSize: 14),
                  );
                })
          ],
        ),
      ),
    );
  }
}
