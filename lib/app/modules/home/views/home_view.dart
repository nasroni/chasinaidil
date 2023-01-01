import 'dart:ui';

import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/views/searchresults.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import './searchbar.dart';
import './searchappbar.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AppController appc = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.top]);

    controller.import();
    return Obx(() => Scaffold(
          body: Container(
            color: Get.theme.backgroundColor,
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(
                    milliseconds: 230,
                  ),
                  curve: Curves.linear,
                  child: SearchAppBar(
                    size: controller.isSearchActive.value ? 0 : 100,
                  ),
                ),
                SearchBar(),
                Expanded(
                  child: controller.isSearchActive.value
                      ? SearchResultView()
                      : Center(
                          child: controller.isDBfilled.value
                              ? const Text("DB ready")
                              : const CircularProgressIndicator(),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
