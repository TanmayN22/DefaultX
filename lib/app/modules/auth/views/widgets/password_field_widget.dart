// lib/app/modules/auth/views/widgets/password_field_widget.dart
import 'package:defaultx/app/modules/auth/controllers/auth_controller.dart'; // Updated path and name
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({super.key, required this.controller});

  final AuthController controller; // Updated controller type

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: controller.passwordController,
        obscureText: controller.isPasswordHidden.value,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordHidden.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              controller.isPasswordHidden.toggle();
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }
}
