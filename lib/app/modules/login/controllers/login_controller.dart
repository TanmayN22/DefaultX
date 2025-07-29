// 📁 lib/app/modules/login/controllers/login_controller.dart

import 'package:defaultx/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // A key for the form to enable validation
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Text editing controllers for the input fields
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable booleans to track state
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  // The main login logic
  Future<void> login() async {
    // 1. Validate the form
    if (!loginFormKey.currentState!.validate()) {
      return; // If form is not valid, do nothing
    }

    try {
      isLoading.value = true; // Start loading

      // --- FAKE API CALL ---
      // In a real app, you would make a network request here.
      await Future.delayed(const Duration(seconds: 2));
      // --- END FAKE API CALL ---

      // If login is successful, navigate to the home screen.
      // Get.offAllNamed removes all previous screens (like the login screen)
      // from the navigation stack, so the user can't go back to it.
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Dispose controllers when the screen is closed to free up memory
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
