import 'dart:developer';
import 'dart:io';

import 'package:al_downloader/al_downloader.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/playlist.dart' as my;
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/album/controllers/album_controller.dart';
import 'package:chasinaidil/app/modules/album/views/album_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';

import 'home/controllers/home_controller.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    ALDownloader.initialize();
    ALDownloader.configurePrint(enabled: false, frequentEnabled: false);

    super.onInit();
  }

  RxBool isCurrentlyPlayingView = false.obs;

  List<Audio> currentAudios = List.empty(growable: true);

  placePlaylist(List<Song> songs, String? songTitle) async {
    log('songtitle: $songTitle');
    // Convert songs to Audio objects (with metas)
    currentAudios.clear();
    for (var song in songs) {
      currentAudios.add(await song.audio);
    }
    // get start index depending on titlt
    int startIndex = 0;
    if (songTitle != null) {
      startIndex = currentAudios
          .indexWhere((Audio audio) => audio.metas.title == songTitle);
      if (startIndex == -1) startIndex = 0;
    }

    // Build playlist
    Playlist playlist = Playlist(
      audios: currentAudios,
      startIndex: startIndex,
    );

    // Start playlist
    //player.pause();
    await player.stop();

    player.open(
      playlist,
      audioFocusStrategy: const AudioFocusStrategy.request(
        resumeAfterInterruption: true,
      ),
      autoStart: true,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
      loopMode: LoopMode.none,
      playInBackground: PlayInBackground.enabled,
      showNotification: true,
    );
  }

  Future<List<Song>> getAllDownloadedSongsFromBook(
      SongBook book, bool reverse) async {
    IsarService isar = Get.find();
    String title = HomeController.giveBookTitle(book);
    List<Song> songs = await isar.getAllSongsFromSongBook(title);
    return getAllDownloadedFromSonglist(songs, reverse);
  }

  Future<List<Song>> getAllDownloadedSongsFromAlbum(
      Album album, bool reverse) async {
    IsarService isar = Get.find();
    List<Song> songs = await isar.getSongsFromAlbum(album);
    return getAllDownloadedFromSonglist(songs, reverse);
  }

  Future<List<Song>> getAllDownloadedSongsFromPlaylist(
      my.Playlist playlist, bool reverse) async {
    List<Song> songs = await playlist.giveSongList();
    return getAllDownloadedFromSonglist(songs, reverse);
  }

  List<Song> getAllDownloadedFromSonglist(List<Song> songs, bool reverse) {
    if (!reverse) {
      // return downloaded songs
      return songs.where((Song e) => e.isDownloaded).toList();
    } else {
      // return UNdownloaded songs
      return songs.where((Song e) => !e.isDownloaded).toList();
    }
  }

  final RxBool isDownloadingMultiple = false.obs;
  final RxDouble downloadPercentageMultiple = 100.0.obs;
  RxString idCurrentlyDLMultiple = "".obs;
  SongBook songBookCurrentlyDLMultiple = SongBook.chasinaidil;

  final RxBool isDownloadingSingle = false.obs;
  final RxDouble downloadPercentageSingle = 100.0.obs;

  // download a single song, for use in audio menu
  Future<void> downloadSong(Song song) async {
    // reset download progress notifiers
    isDownloadingSingle.value = true;
    downloadPercentageSingle.value = 0;
    update(['updateViews']);

    // get inapp folder
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // take and ensure existence of songbookpath
    Directory bookDir = Directory('${appDocDir.path}/${song.book}');
    bookDir.createSync();

    // remove old download if it has
    ALDownloader.cancelAll();

    ALDownloader.remove(song.audioPathOnline);
    // Start download
    ALDownloader.download(
      song.audioPathOnline,
      directoryPath: bookDir.path,
      fileName: "${song.songNumber}.mp3",
      redownloadIfNeeded: true,
    );

    // gather progress data
    ALDownloader.addDownloaderHandlerInterface(
      ALDownloaderHandlerInterface(
        succeededHandler: () async {
          // reset download progress, as was before starting, so another song can be downloaded too
          isDownloadingSingle.value = false;
          downloadPercentageSingle.value = 100;
          // then mark song as downloaded
          markSongDownloaded(song);
        },
        failedHandler: () {
          // reset download progress, as was before starting, so it can be started again
          isDownloadingSingle.value = false;
          downloadPercentageSingle.value = 100;
          log('moin');
          // here don't update anything
        },
        progressHandler: (progress) {
          // update progress percentage
          downloadPercentageSingle.value = (progress * 100).toPrecision(2);
        },
      ),
      song.audioPathOnline,
    );
  }

  // download list
  downloadList(List<Song> songs) async {
    log("list downloading");
    downloadPercentageMultiple.value = 0.0;
    isDownloadingMultiple.value = true;
    update(['updateViews']);
    // get inapp folder
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // make list with download items
    List<ALDownloaderBatcherInputVO> vos = songs.map((Song song) {
      // take and ensure existence of songbookpath
      Directory bookDir = Directory('${appDocDir.path}/${song.book}');
      bookDir.createSync();

      // Create a VO with url, path and filename
      return ALDownloaderBatcherInputVO(song.audioPathOnline)
        ..directoryPath = bookDir.path
        ..fileName = "${song.songNumber}.mp3"
        ..redownloadIfNeeded = true;
    }).toList();

    ALDownloaderBatcher.remove(
      vos.map((ALDownloaderBatcherInputVO e) => e.url).toList(),
    );

    // start download
    ALDownloaderBatcher.downloadUrlsWithVOs(
      vos,
      downloaderHandlerInterface: ALDownloaderHandlerInterface(
        succeededHandler: () async {
          // reset download progress, as was before starting, so another song can be downloaded too
          isDownloadingMultiple.value = false;
          downloadPercentageMultiple.value = 100;

          // then mark downloaded songs as downloaded
          for (var song in songs) {
            // check if song is on local disk
            bool isSuccessfull =
                await ALDownloaderFileManager.isExistPhysicalFilePathForUrl(
              song.audioPathOnline,
            );
            if (isSuccessfull) {
              markSongDownloaded(song);
            }
          }
          idCurrentlyDLMultiple.value = "";
          update(['updateViews']);
        },
        failedHandler: () {
          log("failed somehow");
          // reset download progress, as was before starting, so it can be started again
          isDownloadingMultiple.value = false;
          downloadPercentageMultiple.value = 100.0;
          idCurrentlyDLMultiple.value = "";

          // here don't update anything
        },
        progressHandler: (progress) async {
          // update progress percentage
          log("progr:$progress");
          downloadPercentageMultiple.value = (progress * 100).toPrecision(2);
          for (var song in songs) {
            // check if song is on local disk
            bool isSuccessfull =
                await ALDownloaderFileManager.isExistPhysicalFilePathForUrl(
              song.audioPathOnline,
            );
            //if (Platform.isAndroid) {
            isSuccessfull = (await ALDownloaderBatcher.getStatusForUrls(
                    [song.audioPathOnline])) ==
                ALDownloaderStatus.succeeded;
            //}
            if (isSuccessfull && !song.isDownloaded) {
              markSongDownloaded(song);
            }
          }
        },
      ),
    );
  }

  void markSongDownloaded(Song song) {
    // save to getstorage that when song was saved
    GetStorage().write(song.id.toString(), DateTime.now().toIso8601String());
    update(['updateViews']);
  }

  //final player = AudioPlayer();
  final player = AssetsAudioPlayer();

  RxBool isSeeking = false.obs;
  RxDouble seekingVal = 0.0.obs;

  void playlistDialog(Song song) async {
    IsarService isar = Get.find();
    List<my.Playlist> playlists = await isar.getAllPlaylists();

    if (playlists.isEmpty) {
      await newPlaylist(song);
      playlists = await isar.getAllPlaylists();
      Get.back();
      return;
    }
    List<Widget> buttons = [];
    for (my.Playlist playlist in playlists) {
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
      playlist: my.Playlist(),
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
    my.Playlist? playlist = await Get.to(const AlbumView(nested: 1));
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

  final my.Playlist playlist;

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
