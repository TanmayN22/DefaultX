import 'package:defaultx/app/routes/app_routes.dart';
import 'package:defaultx/app/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            // --- THIS IS THE FIX FOR THE LOGOUT BUTTON ---
            onPressed: () {
              // 1. Find the always-available AuthService.
              final authService = Get.find<AuthService>();
              // 2. Call the service to clear the token.
              authService.clearToken();
              // 3. Navigate back to the login screen.
              Get.offAllNamed(AppRoutes.LOGIN);
            },
          ),
        ],
      ),
      body: Center(
        // The Obx widget will automatically rebuild when the controller's
        // variables (isLoading, userEmail) change.
        child: Obx(() {
          if (controller.isLoading.value) {
            // Show a loading indicator while fetching data.
            return const CircularProgressIndicator();
          } else {
            // Once loaded, display the welcome message.
            return Text(
              'Welcome, ${controller.userEmail.value}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
          }
        }),
      ),
    );
  }
}
