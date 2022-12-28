import 'package:chasinaidil/app/data/services/isar_service.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(
      IsarService(),
      permanent: true,
    );
  }
}
