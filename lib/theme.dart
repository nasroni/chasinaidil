import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();
  //AppTheme._();

  final lightThemeData = ThemeData(
    secondaryHeaderColor: Colors.blueGrey.shade600,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    shadowColor: Colors.grey.shade100,
    unselectedWidgetColor: Colors.grey.shade200,
    dividerColor: Colors.grey.shade300,
    cardColor: Colors.black45,
    primaryTextTheme: const TextTheme(
      bodyMedium: TextStyle(
        //fontFamily: 'UbuntuMono',
        fontSize: 18,
      ),
      bodySmall: chordText,
      bodyLarge: chordLyricsText,
      displayLarge: lyricsText,
      displayMedium: lyricsTitleText,
      displaySmall: chordsTitleText,
    ),
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
      bodySmall: const TextStyle(
        color: Colors.black45,
        fontSize: 15,
      ),
      displayLarge: _displayLarge,
      displayMedium:
          _displayLarge.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
      displaySmall: const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        fontFamily: '.SF Pro Text',
        letterSpacing: -0.4,
      ),
    ),
  );

  static const _displayLarge = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );

  lightTheme() => lightThemeData;
  darkTheme() => darkThemeData;

  late final darkThemeData = lightThemeData.copyWith(
    secondaryHeaderColor: Colors.blueGrey.shade800,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    shadowColor: Colors.black.withBlue(15).withRed(15).withGreen(15),
    unselectedWidgetColor: Colors.black.withBlue(30).withRed(30).withGreen(30),
    primaryColor: Colors.grey.shade100,
    dividerColor: Colors.grey.shade800,
    cardColor: Colors.grey.shade400,
    primaryTextTheme: TextTheme(
      bodySmall: lightThemeData.primaryTextTheme.bodySmall?.copyWith(
        color: const Color.fromARGB(255, 78, 104, 255),
      ),
      bodyLarge: lightThemeData.primaryTextTheme.bodyLarge?.copyWith(
        color: Colors.grey.shade200,
      ),
      displayLarge: lightThemeData.primaryTextTheme.displayLarge?.copyWith(
        color: Colors.grey.shade200,
      ),
      displayMedium: lightThemeData.primaryTextTheme.displayMedium?.copyWith(
        color: const Color.fromARGB(255, 78, 104, 255),
      ),
      displaySmall: lightThemeData.primaryTextTheme.displaySmall?.copyWith(
        color: const Color.fromARGB(255, 78, 104, 255),
      ),
      bodyMedium: lightThemeData.primaryTextTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade100,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: lightThemeData.textTheme.titleLarge?.copyWith(
        color: Colors.grey.shade100,
      ),
      bodyMedium: lightThemeData.textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade100,
      ),
      bodySmall: lightThemeData.textTheme.bodySmall?.copyWith(
        color: Colors.grey.shade600,
      ),
      displayLarge: lightThemeData.textTheme.displayLarge?.copyWith(
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
