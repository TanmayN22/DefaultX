import 'package:defaultx/app/modules/auth/views/auth_screen.dart';
import 'package:defaultx/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/auth/bindings/auth_binding.dart';

class AppPages {
  static const INITIAL = AppRoutes.AUTH;

  static final routes = [
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
