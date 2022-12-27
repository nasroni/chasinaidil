import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: !controller.searchActive.value
              ? AppBar(
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
                )
              : PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(),
                ),
          body: Container(
            color: Get.theme.backgroundColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Platform.isAndroid ? 15 : 10,
                          horizontal: controller.searchActive.value ? 10 : 15),
                      width: controller.searchActive.value
                          ? Get.width - 70
                          : Get.width,
                      child: CupertinoSearchTextField(
                        autocorrect: false,
                        placeholder: 'Ҷустуҷӯ',
                        onTap: () {
                          controller.openSearch();
                        },
                        onSubmitted: (value) {
                          controller.closeSearch();
                          FocusScope.of(context).requestFocus();
                        },
                      ),
                    ),
                    controller.searchActive.value
                        ? TextButton(
                            onPressed: () {
                              controller.closeSearch();
                              FocusScope.of(context).unfocus();
                            },
                            child: Text("Қатъ"),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
