import 'dart:ui';

import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:chasinaidil/app/data/types/song.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:isar/isar.dart';

part 'playlist.g.dart';

@collection
class Playlist {
  Id id = Isar.autoIncrement;

  String? name;

  // ignore: unnecessary_getters_setters
  String get hexcolor => _color;
  set hexcolor(String color) => _color = color;

  @ignore
  Color get colorFore => HexColor(hexcolor);
  @ignore
  Color get colorBack => HexColor(_color).withAlpha(120);
  @ignore
  String _color = RandomColor.getColor(
    Options(
      luminosity: Luminosity.dark,
      format: Format.hex,
    ),
  );
  void newColor() {
    _color = RandomColor.getColor(
      Options(
        luminosity: Luminosity.dark,
        format: Format.hex,
      ),
    );
  }

  void setColor(String hex) {
    _color = hex;
  }

  void setName(String val) {
    if (val.isNotEmpty) {
      name = val;
    }
  }

  List<int> songIds = List.empty(growable: true);

  @ignore
  final IsarService isar = Get.find();

  Future<void> addSong(Song song, {bool shallClose = true}) async {
    if (!songIds.contains(song.id)) {
      songIds = [...songIds, song.id];
      await isar.savePlaylist(this);
    }
    if (shallClose) {
      Get.back();
    }
  }

  Future<void> removeSong(Song song) async {
    songIds = [...songIds]..remove(song.id);
    await isar.savePlaylist(this);
  }

  Future<List<Song>> giveSongList() async {
    IsarService isar = Get.find();
    if (songIds.isEmpty) return Future.value(List<Song>.empty());
    return await isar.getSongsByIds(songIds);
  }

  saveSongList(List<Song> songs) {
    songIds.clear();
    for (var song in songs) {
      songIds.add(song.id);
    }
  }
}
