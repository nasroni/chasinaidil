import 'package:get/get.dart';

import '../controllers/lyrics_controller.dart';

class LyricsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LyricsController>(
      () => LyricsController(),
    );
  }
}
