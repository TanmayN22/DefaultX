// lib/app/modules/auth/controllers/auth_controller.dart
import 'package:defaultx/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import http
import 'dart:convert'; // For json encoding/decoding
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

class AuthController extends GetxController {
  // Renamed class
  final GlobalKey<FormState> authFormKey =
      GlobalKey<FormState>(); // Renamed key

  final emailController = TextEditingController(); // Changed to email
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  // Base URL for your backend API
  final String _baseUrl =
      'http://localhost:3000/api'; // Adjust if your backend runs on a different IP/Port

  @override
  void onInit() {
    super.onInit();
    // Optional: Check for existing token on app start
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    if (token != null && token.isNotEmpty) {
      // You might want to validate the token with the backend here
      // For simplicity, we'll assume it's valid if present
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  Future<void> login() async {
    if (!authFormKey.currentState!.validate()) {
      // Updated key
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text, // Changed to email
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];

        // Store the token securely (e.g., using shared_preferences or flutter_secure_storage)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        Get.snackbar(
          'Success',
          'Logged in successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.HOME);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        Get.snackbar(
          'Login Failed',
          errorData['message'] ??
              'An unexpected error occurred. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error during login: $e'); // Log the error for debugging
      Get.snackbar(
        'Login Failed',
        'Could not connect to the server. Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Add a logout function to clear the token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token'); // Clear the stored token
    Get.offAllNamed(AppRoutes.AUTH); // Navigate back to auth screen
  }

  @override
  void onClose() {
    emailController.dispose(); // Changed to email
    passwordController.dispose();
    super.onClose();
  }
}
