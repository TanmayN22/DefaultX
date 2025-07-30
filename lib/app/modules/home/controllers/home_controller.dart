// lib/app/modules/home/controllers/home_controller.dart
// Keep for general routing if needed
import 'package:get/get.dart';
import 'package:defaultx/app/modules/login/controllers/login_controller.dart'; // Import AuthController

class HomeController extends GetxController {
  // Inject AuthController to use its logout method
  final LoginController _authController = Get.find<LoginController>();

  void logout() {
    _authController.logout(); // Call the logout method from AuthController
  }
}
