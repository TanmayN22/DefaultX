import 'package:defaultx/app/modules/login/views/widgets/forgot_password_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/login_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/password_field_widget.dart';
import 'package:defaultx/app/modules/login/views/widgets/username_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../controllers/login_controller.dart';

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
                    const Color(0xFF4285f4).withOpacity(0.6),
                    const Color(0xFF1976d2).withOpacity(0.3),
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
                    const Color(0xFF7C4DFF).withOpacity(0.4),
                    const Color(0xFF3F51B5).withOpacity(0.2),
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
                    const Color(0xFFE3F2FD).withOpacity(0.3),
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
                          // Your logo here
                          SizedBox(
                            width: 500,
                            height: 500,
                            child: Center(
                              child: Image.asset(
                                'assets/defaultx_logo.png',
                                width: 1000,
                                height: 1000,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Middle divider
                  Container(
                    height: 700,
                    width: 1.5,
                    decoration: BoxDecoration(color: Colors.black45),
                  ),

                  // Right side - Login form
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
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
                                key: controller.loginFormKey,
                                child: Column(
                                  children: [
                                    UsernameFieldWidget(controller: controller),
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
