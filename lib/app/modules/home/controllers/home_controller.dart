// 📁 lib/app/modules/home/controllers/home_controller.dart

import 'package:defaultx/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void logout() {
    // Navigate back to the login screen, clearing the history
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
