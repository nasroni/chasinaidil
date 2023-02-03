import 'dart:io';

import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/prefs.dart';
import 'package:chasinaidil/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class SearchAppBar extends StatelessWidget {
  final int size;
  const SearchAppBar({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 20),
          child: TextButton(
              style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return context.theme.shadowColor;
                  } else {
                    return Colors.transparent;
                  }
                }),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
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
                GetStorage().remove(Prefs.darkMode);
                Get.changeThemeMode(ThemeMode.system);
              },
              child: Icon(
                context.isDarkMode
                    ? CupertinoIcons.moon_fill
                    : CupertinoIcons.moon,
                color: context.theme.primaryColor,
              )),
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
