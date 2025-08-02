// lib/app/modules/login/controllers/login_controller.dart

import 'package:defaultx/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'; // Import Dio for specific error handling

// Import the services we created
import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';

class LoginController extends GetxController {
  // --- Your existing properties are kept ---
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  // --- ADDED: Instances of our services ---
  // We use Get.find() to get the service instances that were initialized in main.dart
  final ApiService _apiService = Get.find<ApiService>();
  final AuthService _authService = Get.find<AuthService>();

  // REMOVED: The _baseUrl is no longer needed here. It's configured centrally in ApiService.
  // REMOVED: The onInit and _checkLoginStatus methods are no longer needed.
  // This logic is now handled automatically by the AuthService and the initialRoute in main.dart.

  /// Attempts to log the user in using the ApiService.
  Future<void> login() async {
    // Your existing form validation is perfect.
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;

      // --- REPLACED: The http.post call is now a clean call to our ApiService ---
      final response = await _apiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      // --- REPLACED: Token handling is now done via the AuthService ---
      if (response.statusCode == 200) {
        // Extract the token from the response data.
        // This key 'token' must match what your Node.js API sends.
        final String token = response.data['token'];

        // Save the token securely using our AuthService.
        await _authService.saveToken(token);

        Get.snackbar(
          'Success',
          'Logged in successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to the home screen, clearing the navigation stack.
        Get.offAllNamed(AppRoutes.HOME);
      }
      // Note: A non-200 status code will be caught by the DioException handler below.
    } on DioException catch (e) {
      // --- MODIFIED: The catch block now uses DioException for better error details ---
      Get.snackbar(
        'Login Failed',
        // Show the specific error message from your Node.js server if it exists.
        e.response?.data['message'] ?? 'An unexpected error occurred.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      // A general catch block for other errors (e.g., no internet).
      print('Error during login: $e');
      Get.snackbar(
        'Login Failed',
        'Could not connect to the server. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Logs the user out by clearing the token via the AuthService.
  Future<void> logout() async {
    // --- REPLACED: SharedPreferences logic is now a simple call to our AuthService ---
    await _authService.clearToken();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
