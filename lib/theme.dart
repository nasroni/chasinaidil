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

  static final darkTheme = ThemeData(
    backgroundColor: Colors.black87,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
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
    fontFamily: 'OverpassMono',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Color.fromARGB(255, 40, 56, 145),
  );

  static const chordLyricsText = TextStyle(
    fontFamily: 'OverpassMono',
    fontSize: 16,
    color: Colors.black,
  );

  static const lyricsTitleText = TextStyle(
      fontFamily: 'OverpassMono',
      fontWeight: FontWeight.w500,
      fontSize: 19,
      //color: Colors.black87,
      color: Color.fromARGB(255, 40, 56, 145)
      //fontStyle: FontStyle.italic,
      );
}
