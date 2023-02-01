import 'package:get/get.dart';

import '../controllers/album_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumController>(
      () => AlbumController(),
    );
  }
}
