import 'package:chasinaidil/app/data/types/album.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  final Album album = Get.arguments;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
