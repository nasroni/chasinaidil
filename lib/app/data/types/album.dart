import 'dart:ffi';

import 'package:chasinaidil/app/data/types/playlist.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';

class Album {
  Album(this.title, this.albumId, this._coverPath, this.songBook);

  Album.fromPlaylist(Playlist this.playlist)
      : title = playlist.name ?? '',
        _coverPath = '',
        albumId = playlist.id,
        songBook = SongBook.playlists;
  Album.newPlaylist()
      : title = 'Нав лист ...',
        _coverPath = '',
        albumId = 999999999999999999,
        songBook = SongBook.playlists,
        playlist = Playlist()..hexcolor = "#de7e00";

  final String title;
  final int albumId;
  final String _coverPath;
  final SongBook songBook;
  Playlist? playlist;

  String get coverPathHq => '${_coverPath}_hq.jpg';
  String get coverPath => '$_coverPath.jpg';

  static String _genPath(int albumId, SongBook songBook) {
    var folderPath;
    switch (songBook) {
      case SongBook.chasinaidil:
        folderPath = 'chasinaidil';
        break;
      case SongBook.tshashma:
        folderPath = 'tshashma';
        break;
      default:
        folderPath = '';
    }
    String albumIdString = albumId.toString().padLeft(2, '0');
    return 'assets/$folderPath/covers/cd_$albumIdString';
  }

  static List<Album> list(SongBook songBook) {
    switch (songBook) {
      case SongBook.chasinaidil:
        return [
          Album('Забур', 0, _genPath(0, songBook), songBook),
          Album('Исо омадааст', 1, _genPath(1, songBook), songBook),
          Album('Чашмаи ҳаёт', 2, _genPath(2, songBook), songBook),
          Album('Дар шаби охир', 3, _genPath(3, songBook), songBook),
          Album('Нури ҷаҳон', 4, _genPath(4, songBook), songBook),
          Album('Барраи Худо', 5, _genPath(5, songBook), songBook),
          Album('Моҳигир', 6, _genPath(6, songBook), songBook),
          Album('Шарирон', 7, _genPath(7, songBook), songBook),
          Album('Худои воҷибулвуҷуд', 8, _genPath(8, songBook), songBook),
          Album('Пари... меҳрубон', 9, _genPath(9, songBook), songBook),
          Album('Эй Наҷоткор', 10, _genPath(10, songBook), songBook),
          Album('Ту кӯзагарӣ', 11, _genPath(11, songBook), songBook),
          Album('Бимон бо ман', 12, _genPath(12, songBook), songBook),
          Album('Дурӯзаи умрам', 13, _genPath(13, songBook), songBook),
          Album('Чӯпони некӯ', 14, _genPath(14, songBook), songBook),
          Album('Худоё, бубахшо', 15, _genPath(15, songBook), songBook),
          Album('Пирӯзӣ бар марг', 16, _genPath(16, songBook), songBook),
        ];
      case SongBook.tshashma:
        return [
          Album('Чашма 1', 1, _genPath(1, songBook), songBook),
          Album('Чашма 2', 2, _genPath(2, songBook), songBook),
        ];
      case SongBook.playlists:
        return [
          Album.fromPlaylist(Playlist()..name = 'Playlist 1'),
          Album.fromPlaylist(Playlist()..name = 'Next Playlist'),
          Album.newPlaylist(),
        ];
      //return [];
      default:
        return [];
    }
  }
}
