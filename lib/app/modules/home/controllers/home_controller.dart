import 'package:defaultx/app/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  void logout() {
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
