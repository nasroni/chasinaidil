import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    backgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 30,
      ),
      bodyMedium: TextStyle(
        //fontFamily: 'UbuntuMono',
        fontSize: 18,
      ),
    ),
  );

  static const chordText = TextStyle(
    fontFamily: 'NotoSansMono',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Colors.indigo,
  );

  static const chordLyricsText = TextStyle(
    fontFamily: 'NotoSansMono',
    fontSize: 16,
    color: Colors.black,
  );

  static const lyricsTitleText = TextStyle(
    fontSize: 19,
    color: Colors.black54,
    fontStyle: FontStyle.italic,
  );
}
