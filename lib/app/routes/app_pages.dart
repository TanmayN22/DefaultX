import 'package:defaultx/app/modules/applicant_management/bindings/applicant_management_binding.dart';
import 'package:defaultx/app/modules/applicant_management/views/applicant_management_view.dart';
import 'package:defaultx/app/modules/login/views/login_screen.dart';
import 'package:defaultx/app/modules/reports/views/reports_view.dart';
import 'package:defaultx/app/modules/settings/views/settings_view.dart';
import 'package:defaultx/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';

class AppPages {
  static const INITIAL = AppRoutes.LOGIN;

  static final routes = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.APPLICATIONS,
      page: () => ApplicantManagementView(),
      binding: ApplicantManagementBinding(),
    ),
    GetPage(name: AppRoutes.REPORTS, page: () => ReportsView()),
    GetPage(name: AppRoutes.SETTINGS, page: () => SettingsView()),
  ];
}
