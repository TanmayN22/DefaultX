import 'package:defaultx/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class UsernameFieldWidget extends StatelessWidget {
  const UsernameFieldWidget({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(Icons.person_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        return null;
      },
    );
  }
}
