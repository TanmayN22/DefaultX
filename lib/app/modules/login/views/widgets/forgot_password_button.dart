// lib/app/modules/auth/views/widgets/forgot_password_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// No controller reference needed here, as it just shows a snackbar

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.snackbar(
          'Info',
          'Forgot Password feature coming soon!',
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: 400,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          backgroundColor: Colors.black.withOpacity(0.8),
          colorText: Colors.white,
        );
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
