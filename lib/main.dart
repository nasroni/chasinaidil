import 'package:chasinaidil/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'app/localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/routes/app_pages.dart';
import 'prefs.dart';

Future<void> main() async {
  await GetStorage.init();
  var themeMode = GetStorage().read(Prefs.darkMode) ?? ThemeMode.system;
  themeMode = themeMode.runtimeType == ThemeMode
      ? themeMode
      : (themeMode ? ThemeMode.dark : ThemeMode.light);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await JustAudioBackground.init(
    androidNotificationChannelId: 'one.nasroni.chasinaidil.channel.audio',
    androidNotificationChannelName: 'Khazinaidil player',
    androidNotificationOngoing: true,
  );

  runApp(
    GetMaterialApp(
      title: "Хазинаи Дил",
      theme: AppTheme().lightTheme(),
      darkTheme: AppTheme().darkTheme(),
      themeMode: themeMode,
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
