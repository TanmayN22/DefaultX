// lib/app/modules/auth/views/auth_screen.dart
import 'package:defaultx/app/modules/auth/views/widgets/forgot_password_button.dart';
import 'package:defaultx/app/modules/auth/views/widgets/login_button.dart';
import 'package:defaultx/app/modules/auth/views/widgets/password_field_widget.dart';
import 'package:defaultx/app/modules/auth/views/widgets/email_field_widget.dart'; // Renamed from username
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../controllers/auth_controller.dart'; // Updated path and name
import 'package:rive/rive.dart' hide LinearGradient, RadialGradient, Image; // For Rive animation

class AuthScreen extends GetView<AuthController> {
  // Renamed class
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with white top and gradient bottom
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.6, 1, 1.0],
                colors: const [
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

          // Main content with logo/animation on left and login form on right
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  // Left side - Logo/Animation section
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
                                'assets/defaultx_logo.png', // <--- Ensure this path is correct!
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
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(25, 0, 0, 0),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
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
                                key: controller.authFormKey, // Updated key
                                child: Column(
                                  children: [
                                    EmailFieldWidget(
                                      controller: controller,
                                    ), // Renamed widget
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
