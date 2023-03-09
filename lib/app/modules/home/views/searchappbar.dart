import 'dart:io';

import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/lyrics/views/playerdialog.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchAppBar extends StatelessWidget {
  final int size;
  const SearchAppBar({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    AppController appc = Get.find();
    return AppBar(
      title: Container(
        padding: const EdgeInsets.only(top: 35),
        child: const Text('Хазинаи Дил'),
      ),
      centerTitle: false,
      toolbarHeight:
          Platform.isAndroid ? (80 * size) / 100 : (110 * size) / 100,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      titleTextStyle: context.textTheme.titleLarge,
      elevation: 0,
      actions: [
        if (appc.player.current.value != null)
          Container(
            padding: Platform.isAndroid
                ? const EdgeInsets.only(bottom: 30, right: 0)
                : const EdgeInsets.only(bottom: 70, right: 0),
            child: CupertinoButton(
              onPressed: () => Get.dialog(
                  const PlayerDialog(
                    viewingSong: null,
                  ),
                  barrierColor: Colors.transparent,
                  barrierDismissible: true),
              padding: EdgeInsets.zero,
              minSize: kMinInteractiveDimensionCupertino,
              alignment: Alignment.centerRight,
              child: Icon(
                CupertinoIcons.playpause,
                color: context.theme.primaryColor,
                size: 24,
              ),
            ),
          ),
        Container(
          padding: Platform.isAndroid
              ? const EdgeInsets.only(bottom: 30, right: 0)
              : const EdgeInsets.only(bottom: 70, right: 0),
          child: TextButton(
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateColor.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return context.theme.shadowColor;
                } else {
                  return Colors.transparent;
                }
              }),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            onPressed: () {
              GetStorage().write(Prefs.darkMode, !Get.isDarkMode);

              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
              /*Get.changeTheme(
                  Get.isDarkMode
                      ? AppTheme().lightThemeData
                      : AppTheme().darkThemeData,
                );*/
            },
            onLongPress: () {
              Get.changeThemeMode(ThemeMode.system);
              GetStorage().remove(Prefs.darkMode);
            },
            child: Icon(
              context.isDarkMode
                  ? CupertinoIcons.moon_fill
                  : CupertinoIcons.moon,
              color: context.theme.primaryColor,
            ),
          ),
        )
      ],
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: context.theme.primaryColor,
        statusBarIconBrightness: context.theme.brightness,
        statusBarBrightness: context.theme.brightness,
      ),
    );
  }
}
