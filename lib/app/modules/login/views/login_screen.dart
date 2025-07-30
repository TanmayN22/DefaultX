// login_screen.dart
import 'package:defaultx/app/modules/login/views/widgets/background.dart';
import 'package:defaultx/app/modules/login/views/widgets/logo_section.dart';
import 'package:defaultx/app/modules/login/views/widgets/login_form_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background with blur effects
          const AnimatedBackground(),
          
          // Main content layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // Left side - Logo section
                  Expanded(
                    flex: 1,
                    child: LogoSection(),
                  ),
                  
                  // Middle divider
                  Container(
                    height: 700,
                    width: 1.5,
                    decoration: const BoxDecoration(color: Colors.black45),
                  ),
                  
                  // Right side - Login form
                  Expanded(
                    flex: 1,
                    child: LoginFormSection(controller: controller),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
