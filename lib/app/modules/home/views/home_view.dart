import 'package:chasinaidil/app/modules/home/views/searchresults.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import './searchbar.dart';
import './searchappbar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
