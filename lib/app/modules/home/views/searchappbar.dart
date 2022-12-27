import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SearchAppBar extends PreferredSize {
  SearchAppBar({super.key})
      : super(
          preferredSize: Size.fromHeight(Platform.isAndroid ? 80 : 110),
          child: Container(),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.only(top: 35),
        child: const Text('Хазинаи Дил'),
      ),
      centerTitle: false,
      toolbarHeight: Platform.isAndroid ? 80 : 110,
      backgroundColor: Get.theme.backgroundColor,
      titleTextStyle: Get.textTheme.titleLarge,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
