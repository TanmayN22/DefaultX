import 'package:defaultx/app/modules/login/views/widgets/forgot_password_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/login_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/password_field_widget.dart';
import 'package:defaultx/app/modules/login/views/widgets/register_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/username_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DefaultX Login'), centerTitle: true),
      body: Align(
        alignment: const Alignment(0.0, -0.4),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ForgotPasswordButton(),
                    RegisterButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
