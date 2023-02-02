import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();
  //AppTheme._();

  final lightThemeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    textTheme: TextTheme(
      titleLarge: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 30,
      ),
      bodyMedium: const TextStyle(
        //fontFamily: 'UbuntuMono',
        fontSize: 18,
      ),
      displayMedium: _displayMedium,
      displaySmall:
          _displayMedium.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
    ),
  );

  static const _displayMedium = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );

  lightTheme() => lightThemeData;
  darkTheme() => darkThemeData;

  late final darkThemeData = lightThemeData.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    primaryColor: Colors.grey.shade100,
    textTheme: TextTheme(
      titleLarge: lightThemeData.textTheme.titleLarge?.copyWith(
        color: Colors.grey.shade100,
      ),
      displayMedium: lightThemeData.textTheme.displayMedium?.copyWith(
        color: Colors.grey.shade100,
      ),
      displaySmall: lightThemeData.textTheme.displaySmall?.copyWith(
        color: Colors.grey.shade100,
      ),
      bodyLarge: lightThemeData.textTheme.bodyLarge?.copyWith(
        color: Colors.grey.shade100,
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

  static const lyricsText = TextStyle(
    fontFamily: 'FiraSans',
    fontSize: 17,
    color: Colors.black,
  );

  static const chordsTitleText = TextStyle(
      fontFamily: 'OverpassMono',
      fontWeight: FontWeight.w500,
      fontSize: 19,
      //color: Colors.black87,
      color: Color.fromARGB(255, 40, 56, 145)
      //fontStyle: FontStyle.italic,
      );

  static const lyricsTitleText = TextStyle(
      fontFamily: 'FiraSans',
      fontWeight: FontWeight.w500,
      fontSize: 19,
      //color: Colors.black87,
      color: Color.fromARGB(255, 40, 56, 145)
      //fontStyle: FontStyle.italic,
      );
}
