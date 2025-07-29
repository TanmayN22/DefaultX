import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Get.snackbar(
          'Info',
          'Registration feature coming soon!',
          snackPosition: SnackPosition.BOTTOM,
          maxWidth: 400,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          backgroundColor: Colors.black.withOpacity(0.8),
          colorText: Colors.white,
        );
      },
      child: const Text('Register'),
    );
  }
}
