import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/playlist.dart';
import 'package:chasinaidil/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class Album {
  Album(this.title, this.albumId, this._coverPath, this.songBook);

  Album.fromPlaylist(Playlist this.playlist)
      : title = playlist.name ?? '',
        _coverPath = '',
        albumId = playlist.id + 700000,
        songBook = SongBook.playlists;
  Album.newPlaylist()
      : title = 'Тартиб додан',
        _coverPath = '',
        albumId = 999999999999999999,
        songBook = SongBook.playlists,
        playlist = Playlist()
          ..hexcolor = "#de7e00"
          ..name = 'Тартиб додан';

  final String title;
  final int albumId;
  final String _coverPath;
  final SongBook songBook;
  Playlist? playlist;

  String get coverPathHq => '${_coverPath}_hq.jpg';
  String get coverPath => '$_coverPath.jpg';

  static String genPath(int albumId, SongBook songBook) {
    String folderPath;
    switch (songBook) {
      case SongBook.chasinaidil:
        folderPath = 'chasinaidil';
        break;
      case SongBook.chashma:
        folderPath = 'chashma';
        break;
      default:
        folderPath = '';
    }
    String albumIdString = albumId.toString().padLeft(2, '0');
    return 'assets/$folderPath/covers/cd_$albumIdString';
  }

  static Future<List<Album>> list(SongBook songBook) async {
    switch (songBook) {
      case SongBook.chasinaidil:
        return [
          Album('Забур', 17, genPath(17, songBook), songBook),
          Album('Исо омадааст', 1, genPath(1, songBook), songBook),
          Album('Чашмаи ҳаёт', 2, genPath(2, songBook), songBook),
          Album('Дар шаби охир', 3, genPath(3, songBook), songBook),
          Album('Нури ҷаҳон', 4, genPath(4, songBook), songBook),
          Album('Барраи Худо', 5, genPath(5, songBook), songBook),
          Album('Моҳигир', 6, genPath(6, songBook), songBook),
          Album('Шарирон', 7, genPath(7, songBook), songBook),
          Album('Худои воҷибулвуҷуд', 8, genPath(8, songBook), songBook),
          Album('Пари... меҳрубон', 9, genPath(9, songBook), songBook),
          Album('Эй Наҷоткор', 10, genPath(10, songBook), songBook),
          Album('Ту кӯзагарӣ', 11, genPath(11, songBook), songBook),
          Album('Бимон бо ман', 12, genPath(12, songBook), songBook),
          Album('Дурӯзаи умрам', 13, genPath(13, songBook), songBook),
          Album('Чӯпони некӯ', 14, genPath(14, songBook), songBook),
          Album('Худоё, бубахшо', 15, genPath(15, songBook), songBook),
          Album('Пирӯзӣ бар марг', 16, genPath(16, songBook), songBook),
        ];
      case SongBook.chashma:
        return [
          Album('Чашма 1', 1, genPath(1, songBook), songBook),
          Album('Чашма 2', 2, genPath(2, songBook), songBook),
        ];
      case SongBook.playlists:
        IsarService isar = Get.find();
        List<Playlist> playlists = await isar.getAllPlaylists();
        List<Album> albums = [];

        for (var item in playlists) {
          albums.add(Album.fromPlaylist(item));
        }
        albums.add(Album.newPlaylist());

        return Future.value(albums);
      //return [];
      default:
        return [];
    }
  }
}
