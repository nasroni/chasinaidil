import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
