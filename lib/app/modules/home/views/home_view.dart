import 'package:chasinaidil/app/modules/app_controller.dart';
import 'package:chasinaidil/app/modules/home/views/searchresults.dart';
import 'package:chasinaidil/release_config.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                      : Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              SizedBox(
                                width: context.width,
                                child: CupertinoButton(
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => const Icon(
                                          CupertinoIcons.chevron_right,
                                          color: Colors.black,
                                          size: 25,
                                        )
                                            .animate(
                                              target: controller
                                                      .isChasinaiDilOpen.value
                                                  ? 0
                                                  : 1,
                                            )
                                            .custom(
                                              begin: 0,
                                              end: pi / 2,
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              curve: Curves.ease,
                                              builder: (context, value, child) {
                                                return Transform.rotate(
                                                  angle: value,
                                                  child: child,
                                                );
                                              },
                                            ),
                                      ),
                                      const Text(
                                        ' Хазинаи Дил',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () => controller
                                      .toggleOpenState(SongBook.chasinaidil),
                                ),
                              )
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
