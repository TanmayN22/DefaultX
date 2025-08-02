import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

/// AuthService
///
/// This service is responsible for handling the user's authentication state.
/// It securely stores and retrieves the JWT (JSON Web Token).
class AuthService extends GetxService {
  final _storage = const FlutterSecureStorage();
  final _isLoggedIn = false.obs;

  static const _tokenKey = 'jwt_token';

  /// A public getter to reactively check the login status from anywhere in the app.
  bool get isLoggedIn => _isLoggedIn.value;

  /// Called by GetX when the service is initialized. Checks for a token at app start.
  @override
  void onInit() {
    super.onInit();
    _checkTokenOnStartup();
  }

  Future<void> _checkTokenOnStartup() async {
    final token = await getToken();
    if (token != null) {
      _isLoggedIn.value = true;
    }
  }

  /// Securely saves the JWT to the device after a successful login.
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    _isLoggedIn.value = true;
  }

  /// Retrieves the stored JWT. Returns null if no token is found.
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Deletes the JWT when the user logs out.
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    _isLoggedIn.value = false;
  }
}
