import 'package:defaultx/app/routes/app_pages.dart';
import 'package:defaultx/app/routes/app_routes.dart';
import 'package:defaultx/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return GetMaterialApp(
      title: 'DefaultX App',
      initialRoute: authService.isLoggedIn ? AppRoutes.HOME : AppRoutes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
