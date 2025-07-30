// lib/app/modules/auth/views/widgets/email_field_widget.dart
import 'package:defaultx/app/modules/auth/controllers/auth_controller.dart'; // Updated path and name
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailFieldWidget extends StatelessWidget {
  // Renamed class
  const EmailFieldWidget({super.key, required this.controller});

  final AuthController controller; // Updated controller type

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.emailController, // Changed to emailController
      keyboardType: TextInputType.emailAddress, // Suggest email keyboard
      decoration: InputDecoration(
        labelText: 'Email Address', // Changed label
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: const Icon(Icons.email_outlined), // Changed icon
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!GetUtils.isEmail(value)) {
          // Using GetX utility for email validation
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}
