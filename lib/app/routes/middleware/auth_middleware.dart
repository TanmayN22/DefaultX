import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';

/// AuthMiddleware
///
/// Checks if a user is logged in before allowing access to a route.
/// If not logged in, it redirects them to the login screen.
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();

    // If logged in, allow access (return null).
    // Otherwise, redirect to the '/login' route.
    return authService.isLoggedIn ? null : const RouteSettings(name: '/login');
  }
}
