// lib/app/modules/login/views/login_screen.dart
// Corrected file path comment to reflect the 'login' module
import 'package:defaultx/app/modules/login/views/widgets/forgot_password_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/login_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/password_field_widget.dart';
import 'package:defaultx/app/modules/login/views/widgets/email_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui'; // For ImageFilter.blur

// CRITICAL FIX: Removed the problematic Rive import.
// If you want to use Rive animation later, you must import 'package:rive/rive.dart';
// WITHOUT the 'hide' clause, and ensure your .riv file is in assets/ and declared in pubspec.yaml.
// For now, removing it resolves conflicts with Flutter's core widgets.
// import 'package:rive/rive.dart' hide LinearGradient, RadialGradient, Image;

import '../controllers/login_controller.dart'; // Correctly points to LoginController

// CRITICAL FIX: Changed GetView<LoginButton> to GetView<LoginController>
// The GetView widget must be parameterized with the type of its associated GetxController.
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with white top and gradient bottom
          Container(
            decoration: const BoxDecoration(
              // Added const for performance
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.6, 1, 1.0],
                colors: [
                  Colors.white,
                  Color(0xFFf8f9ff),
                  Color(0xFF4285f4),
                  Color(0xFF1976d2),
                ],
              ),
            ),
          ),

          // Blurred circles for the background effect
          Positioned(
            bottom: -150,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color.fromARGB(153, 66, 133, 244),
                    const Color.fromARGB(76, 25, 118, 210),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -200,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color.fromARGB(102, 124, 77, 255),
                    const Color.fromARGB(51, 63, 81, 181),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            top: 100,
            right: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color.fromARGB(76, 227, 242, 253),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // Blur effect over the circles
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(color: Colors.transparent),
          ),

          // Main content with logo on left and login form on right
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // Left side - Logo section
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 500, // Adjust this SizedBox size if needed
                            height: 500,
                            child: Center(
                              // Center the image within this SizedBox
                              child: Image.asset(
                                // Image.asset is now correctly available
                                'assets/defaultx_logo.png', // Ensure this path is correct!
                                fit: BoxFit.contain, // This is good for scaling
                                // Do NOT add explicit width/height here like width: 1000, height: 1000,
                                // as that will make it too big for the parent SizedBox.
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Seamless Authentication',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Your secure gateway to DefaultX',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
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
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(242, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              // Added const
                              BoxShadow(
                                color: Color.fromARGB(25, 0, 0, 0),
                                blurRadius: 30,
                                offset: Offset(0, 15),
                              ),
                            ],
                            border: Border.all(
                              color: const Color.fromARGB(51, 255, 255, 255),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Sign in to your account',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Form(
                                // CRITICAL FIX: Changed from controller.authFormKey to controller.loginFormKey
                                key: controller.loginFormKey,
                                child: Column(
                                  children: [
                                    EmailFieldWidget(controller: controller),
                                    const SizedBox(height: 16),
                                    PasswordFieldWidget(controller: controller),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              LoginButton(controller: controller),
                              const SizedBox(height: 16),
                              ForgotPasswordButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
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
