import 'package:chasinaidil/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: const Locale('tj'),
      supportedLocales: const [Locale('tj')],
      localizationsDelegates: const [
        TjLocalizationsDelegate(),
        TjLocalizationsDelegateC(),
        GlobalWidgetsLocalizations.delegate,
      ],
    ),
  );
}
