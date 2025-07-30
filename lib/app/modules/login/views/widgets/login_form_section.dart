// widgets/login_form_section.dart
import 'package:defaultx/app/modules/login/controllers/login_controller.dart';
import 'package:defaultx/app/modules/login/views/widgets/forgot_password_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/login_button.dart';
import 'package:defaultx/app/modules/login/views/widgets/password_field_widget.dart';
import 'package:defaultx/app/modules/login/views/widgets/username_field_widget.dart';
import 'package:flutter/material.dart';

class LoginFormSection extends StatelessWidget {
  final LoginController controller;
  
  const LoginFormSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: const Color.fromARGB(242, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
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
              const _FormHeader(),
              const SizedBox(height: 20),
              _LoginForm(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  final LoginController controller;
  
  const _LoginForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          UsernameFieldWidget(controller: controller),
          const SizedBox(height: 16),
          PasswordFieldWidget(controller: controller),
          const SizedBox(height: 24),
          LoginButton(controller: controller),
          const SizedBox(height: 16),
          ForgotPasswordButton(),
        ],
      ),
    );
  }
}
