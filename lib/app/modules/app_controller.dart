import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:al_downloader/al_downloader.dart';
import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/album.dart';
import 'package:chasinaidil/app/data/types/playlist.dart' as my;
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:chasinaidil/app/modules/album/controllers/album_controller.dart';
import 'package:chasinaidil/app/modules/album/views/album_view.dart';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'home/controllers/home_controller.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    ALDownloader.initialize();
    ALDownloader.configurePrint(enabled: false, frequentEnabled: false);

    jplayer.playbackEventStream.listen((_) async {
      int? index = jplayer.currentIndex;
      log("indexStream: $index");
      if (index == null ||
          currentAudios.isEmpty ||
          currentAudios.length < (index)) {
        //mediaItemStreamController.add(null);
      } else {
        var mediaItem = (currentAudios[index].tag as MediaItem);
        if (mediaItem != currentMediaItem) {
          mediaItemStreamController.add(mediaItem);
          currentMediaItem = mediaItem;
        }

        /*IsarService isar = Get.find();

        songStreamContr.add(await isar.getSongById(int.parse(indx)));*/
      }
    });

    super.onInit();
  }

  final RxBool isSending = false.obs;
  final RxBool isReceiving = false.obs;
  final StreamController<int> sendingPercentageSC =
      StreamController<int>.broadcast();
  final StreamController<int> receivingPercentageSC =
      StreamController<int>.broadcast();
  Stream<int> get sendingPercentage => sendingPercentageSC.stream;
  Stream<int> get receivingPercentage => receivingPercentageSC.stream;

  void sendSongs() async {
    if (isReceiving.value) {
      return;
    } else if (isSending.value) {
      isSending.value = false;
      return;
    } else {
      isSending.value = true;
    }

    // start of business logic
    final dataDir = await getApplicationDocumentsDirectory();
    final saveDir = await getTemporaryDirectory();
    final zipFile = File("${saveDir.path}/songAudios.zip");
    if (zipFile.existsSync()) {
      zipFile.deleteSync();
    }

    try {
      await ZipFile.createFromDirectory(
          sourceDir: dataDir,
          zipFile: zipFile,
          recurseSubDirs: true,
          onZipping: (filePath, dir, progress) {
            if (dir) return ZipFileOperation.includeItem;
            sendingPercentageSC.add(progress.round());
            return filePath.endsWith(".mp3")
                ? ZipFileOperation.includeItem
                : ZipFileOperation.skipItem;
          });
    } catch (e) {
      log(e.toString());
    }
    await Share.shareXFiles([XFile(zipFile.path)]);
    if (zipFile.existsSync()) {
      zipFile.deleteSync();
    }
    isSending.value = false;
  }

  void receiveSongs() async {
    if (isSending.value) {
      return;
    } else if (isReceiving.value) {
      isReceiving.value = false;
      return;
    } else {
      isReceiving.value = true;
    }

    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['zip']);
    final zipFilePath = result?.files.first.path;
    if (zipFilePath == null) {
      isReceiving.value = false;
      return;
    }
    final zipFile = File(zipFilePath);
    final destinationDir = await getApplicationDocumentsDirectory();
    final IsarService isar = Get.find();
    final List<Song> extractedSongs = List.empty(growable: true);

    try {
      await ZipFile.extractToDirectory(
        zipFile: zipFile,
        destinationDir: destinationDir,
        onExtracting: (item, progress) {
          receivingPercentageSC.add((progress * 0.8).toInt());
          var target = File("${destinationDir.path}/${item.name}");
          if (target.existsSync()) {
            target.deleteSync();
          }
          String number = item.name
              .substring(item.name.lastIndexOf('/') + 1, item.name.length - 4);
          var book = item.name.substring(0, item.name.lastIndexOf('/'));
          var songNr = (Song.bookIdForString(book) * 1000) + int.parse(number);
          var song = isar.getSongByIdSync(songNr);
          if (song != null) {
            extractedSongs.add(song);
          }
          return ZipFileOperation.includeItem;
        },
      );
    } catch (e) {
      log('Problem ${e.toString()}');
    }

    var counter = 0;
    for (var song in extractedSongs) {
      await markSongDownloaded(song);
      counter++;
      receivingPercentageSC
          .add((80 + (20 / extractedSongs.length) * counter).round());
    }

    isReceiving.value = false;
    Get.back();
  }

  StreamController<MediaItem?> mediaItemStreamController =
      StreamController<MediaItem?>.broadcast();
  Stream<MediaItem?> get mediaItemStream => mediaItemStreamController.stream;
  MediaItem? currentMediaItem;

  RxBool isCurrentlyPlayingView = false.obs;

  //List<Audio> currentAudios = List.empty(growable: true);
  List<IndexedAudioSource> currentAudios = List.empty(growable: true);

  placePlaylist(List<Song> songs, String? songTitle) async {
    log('songtitle: $songTitle');
    // Convert songs to Audio objects (with metas)
    currentAudios.clear();
    for (var song in songs) {
      var audio = await song.audio;
      currentAudios.add(audio);
    }
    // get start index depending on titlt
    int startIndex = 0;
    if (songTitle != null) {
      startIndex = currentAudios.indexWhere((IndexedAudioSource audio) =>
          (audio.tag as MediaItem).title == songTitle);
      if (startIndex == -1) startIndex = 0;
    }

    // Build playlist
    ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
      children: currentAudios,
    );

    // Start playlist
    //player.pause();
    //await player.stop();

    jplayer.setAudioSource(playlist, initialIndex: startIndex);
    if (!jplayer.playing) {
      jplayer.play();
    }

    /*player.open(
      playlist,
      audioFocusStrategy: const AudioFocusStrategy.request(
        resumeAfterInterruption: true,
      ),
      autoStart: true,
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
      loopMode: LoopMode.none,
      playInBackground: PlayInBackground.enabled,
      showNotification: true,
    );*/
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
          log('finished and resetted');
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
            // check if song is complete downloaded

            double progress =
                await ALDownloader.getProgressForUrl(song.audioPathOnline);
            //log(isSuccessfull.toString());
            //}
            if (progress == 1.0) {
              markSongDownloaded(song);
            }
          }
        },
      ),
    );
  }

  Future<void> markSongDownloaded(Song song) async {
    // save to getstorage that when song was saved
    /*double progress =
        await ALDownloader.getProgressForUrl(song.audioPathOnline);
    ALDownloaderStatus state =
        await ALDownloader.getStatusForUrl(song.audioPathOnline);*/
    /*String? path = await ALDownloaderFileManager.getPhysicalFilePathForUrl(
        song.audioPathOnline);*/
    String path = await song.audioPathLocal;

    /*if (/*progress == 1.0 &&
        state == ALDownloaderStatus.succeeded &&*/
        path != null) {*/
    var md5hash = md5.convert(await File.fromUri(Uri.file(path)).readAsBytes());
    if (md5hash.toString() == song.md5hash) {
      GetStorage().write(song.id.toString(), DateTime.now().toIso8601String());
      update(['updateViews']);
      return;
    } else {
      log("hashing wrong of song ${song.songNumber} ${song.title}");
    }
    //}
    //ALDownloader.remove(song.audioPathOnline);
    update(['updateViews']);
  }

  //final player = AudioPlayer();
  //final player = AssetsAudioPlayer();
  final jplayer = AudioPlayer();

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
