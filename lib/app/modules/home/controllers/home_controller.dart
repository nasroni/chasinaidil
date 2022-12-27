import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final isSearchActive = false.obs;
  final isDBfilled = false.obs;

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

  void openSearch() => isSearchActive.value = true;
  void closeSearch() => isSearchActive.value = false;
}
