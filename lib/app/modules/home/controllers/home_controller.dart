// lib/app/modules/home/controllers/home_controller.dart
import 'package:defaultx/app/routes/app_routes.dart'; // Keep for general routing if needed
import 'package:get/get.dart';
import 'package:defaultx/app/modules/auth/controllers/auth_controller.dart'; // Import AuthController

class HomeController extends GetxController {
  // Inject AuthController to use its logout method
  final AuthController _authController = Get.find<AuthController>();

  void logout() {
    _authController.logout(); // Call the logout method from AuthController
  }
}
