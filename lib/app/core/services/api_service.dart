import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'auth_service.dart';

/// ApiService
///
/// Manages all network requests to your backend API using the Dio package.
/// It automatically adds the JWT to requests and handles auth errors.
class ApiService extends GetxService {
  late Dio _dio;
  final AuthService _authService = Get.find<AuthService>();

  ApiService() {
    // --- IMPORTANT: CONFIGURE YOUR BASE URL FOR DESKTOP ---
    const baseUrl = 'http://localhost:3000/api/';

    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    );

    _dio = Dio(options);

    // Add an interceptor to handle requests and errors globally.
    _dio.interceptors.add(
      InterceptorsWrapper(
        // Before a request is sent, add the token to the header.
        onRequest: (options, handler) async {
          final token = await _authService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        // When a request fails, check for auth errors.
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // If token is invalid/expired, log the user out.
            print('Authentication Error: Token is invalid or expired.');
            await _authService.clearToken();
            Get.offAllNamed('/login'); // Redirect to login
            return;
          }
          return handler.next(e);
        },
      ),
    );
  }

  /// Sends login credentials to the backend.
  Future<Response> login(String email, String password) {
    // Note: The path is relative to the baseUrl.
    return _dio.post('login', data: {'email': email, 'password': password});
  }

  /// Fetches data from a protected route.
  Future<Response> getProtectedData() {
    return _dio.get('protected');
  }
}
