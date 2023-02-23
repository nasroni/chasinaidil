import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/playlist.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/album/controllers/album_controller.dart';
import 'package:chasinaidil/app/modules/album/views/album_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class AppController extends GetxController {
  void playlistDialog(Song song) async {
    IsarService isar = Get.find();
    List<Playlist> playlists = await isar.getAllPlaylists();

    if (playlists.isEmpty) {
      await newPlaylist(song);
      playlists = await isar.getAllPlaylists();
      Get.back();
      return;
    }
    List<Widget> buttons = [];
    for (Playlist playlist in playlists) {
      buttons.add(const SizedBox(
        height: 10,
      ));
      buttons.add(PlaylistSelectButton(
        playlist: playlist,
        song: song,
      ));
    }
    buttons.add(const SizedBox(
      height: 10,
    ));
    buttons.add(PlaylistSelectButton(
      playlist: Playlist(),
      isNewPlaylist: true,
      song: song,
    ));

    Get.dialog(
      CupertinoAlertDialog(
        title: const Text('Плейлистеро интихоб намо'),
        content: Column(
          children: buttons,
        ),
      ),
    );
  }

  static Future<void> newPlaylist(Song song) async {
    var album = Album.newPlaylist();
    Get.put(AlbumController.withAlbum(album), tag: 1.toString());
    Playlist? playlist = await Get.to(const AlbumView(nested: 1));
    playlist?.addSong(song);
  }

  static String transcribe(String input) {
    return input.toLowerCase().split('').map((e) {
      if (!cyrillicLatin.containsKey(e)) return e;
      return cyrillicLatin[e];
    }).join('');
  }

  static Map<String, String> cyrillicLatin = {
    'а': 'a',
    'б': 'b',
    'в': 'v',
    'г': 'g',
    'д': 'd',
    'е': 'e',
    'ё': 'jo',
    'ж': 'zh',
    'з': 'z',
    'и': 'i',
    'й': 'j',
    'к': 'k',
    'л': 'l',
    'м': 'm',
    'н': 'n',
    'о': 'o',
    'п': 'p',
    'р': 'r',
    'с': 's',
    'т': 't',
    'у': 'u',
    'ф': 'f',
    'х': 'kh',
    'ц': 'c',
    'ч': 'ch',
    'ш': 'sh',
    'щ': 'shh',
    'ъ': '',
    'ы': 'y',
    'ь': '',
    'э': 'eh',
    'ю': 'ju',
    'я': 'ja',
    'ғ': 'gh',
    'ӣ': 'i',
    'қ': 'q',
    'ӯ': 'u',
    'ҳ': 'h',
    'ҷ': 'j',
  };
}

class PlaylistSelectButton extends StatelessWidget {
  const PlaylistSelectButton({
    super.key,
    required this.playlist,
    this.isNewPlaylist = false,
    required this.song,
  });

  final Playlist playlist;

  final bool isNewPlaylist;

  final Song song;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => isNewPlaylist
          ? AppController.newPlaylist(song)
          : playlist.addSong(song),
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  color: isNewPlaylist
                      ? HexColor("#de7e00").withAlpha(120)
                      : playlist.colorBack,
                ),
                Positioned.fill(
                  child: Center(
                    child: Icon(
                      isNewPlaylist ? Icons.add : Icons.playlist_add_check,
                      //color: HexColor(colorFore),
                      color: isNewPlaylist
                          ? HexColor("#de7e00")
                          : playlist.colorFore,
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
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              isNewPlaylist ? "Тартиб додан ..." : "${playlist.name}",
              overflow: TextOverflow.ellipsis,
              style: Get.theme.textTheme.displayMedium?.copyWith(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
