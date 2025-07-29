// 📁 lib/app/routes/app_pages.dart

import 'package:defaultx/app/modules/login/views/login_screen.dart';
import 'package:defaultx/app/routes/app_routes.dart';
import 'package:get/get.dart';

// Corrected Imports
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';

class AppPages {
  static const INITIAL = AppRoutes.LOGIN;

  static final routes = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(), // Corrected class name
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
