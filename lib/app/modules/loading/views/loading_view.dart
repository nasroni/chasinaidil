import 'package:chasinaidil/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/loading_controller.dart';

// ignore: must_be_immutable
class LoadingView extends GetView {
  LoadingView({Key? key}) : super(key: key);

  @override
  LoadingController controller = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await controller.import();
      Get.offAndToNamed(Routes.HOME);
    });

    return Scaffold(
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/appicon.png',
              height:
                  (context.isLandscape ? context.height : context.width) / 2,
              width: (context.isLandscape ? context.height : context.width) / 2,
            ),
            SizedBox(
              height:
                  (context.isLandscape ? context.height : context.width) / 7,
            ),
            Image.asset(
              'assets/graphics/loading.gif',
              width:
                  (context.isLandscape ? context.height : context.width) / 10,
            ),
            SizedBox(
              height:
                  (context.isLandscape ? context.height : context.width) / 7,
            ),
            Obx(() => Text(
                  controller.progressState.value,
                  style: const TextStyle(fontSize: 14),
                )),
          ],
        ),
      ),
    );
  }
}
