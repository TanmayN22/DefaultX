import 'package:defaultx/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Make sure you have imported your services and routes
import 'app/services/api_service.dart';
import 'app/services/auth_service.dart';

// The main function MUST be async
Future<void> main() async {
  // This line is required to ensure bindings are ready before services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // This line is the crucial fix. It calls the function to create your services.
  await initServices();

  runApp(const MyApp());
}

/// This function creates and registers your services with GetX.
Future<void> initServices() async {
  print("Initializing services...");
  // Put AuthService first
  await Get.putAsync(() async => AuthService());
  // Then put ApiService, which depends on AuthService
  Get.put(ApiService());
  print("Services initialized.");
}
