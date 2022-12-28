import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        fontSize: 22,
      ),
    ),
  );
}
