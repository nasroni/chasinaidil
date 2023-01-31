import 'package:chasinaidil/prefs.dart';
import 'package:chasinaidil/release_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loading/bindings/loading_binding.dart';
import '../modules/loading/views/loading_view.dart';
import '../modules/lyrics/bindings/lyrics_binding.dart';
import '../modules/lyrics/views/lyrics_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>
          (ReleaseConfig.dbversion == GetStorage().read(Prefs.numDBversion))
              ? HomeView()
              : LoadingView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LYRICS,
      page: () => const LyricsView(),
      binding: LyricsBinding(),
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}
