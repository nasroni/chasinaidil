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
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: Locale('tj'),
      supportedLocales: [Locale('tj')],
      localizationsDelegates: [
        TjLocalizationsDelegate(),
        TjLocalizationsDelegateC(),
        GlobalWidgetsLocalizations.delegate,
      ],
    ),
  );
}
