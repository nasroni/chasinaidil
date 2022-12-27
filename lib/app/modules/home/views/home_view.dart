import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import './searchbar.dart';
import './searchappbar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: !controller.isSearchActive.value
              ? SearchAppBar()
              : PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Container(),
                ),
          body: Container(
            color: Get.theme.backgroundColor,
            child: Column(
              children: [
                SearchBar(),
                Expanded(
                  child: Center(
                    child: controller.isDBfilled.value
                        ? Text("DB filled")
                        : CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
