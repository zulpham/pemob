import 'package:get/get.dart';

import '../modules/home/bindings/bindings.dart';
import '../modules/home/views/home_view.dart';

part 'app_pages.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
