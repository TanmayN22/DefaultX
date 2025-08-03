import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

/// AuthService
///
/// This service is responsible for handling the user's authentication state.
/// It stores and retrieves the JWT using SharedPreferences (no Keychain required).
class AuthService extends GetxService {
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

  Future _checkTokenOnStartup() async {
    final token = await getToken();
    if (token != null) {
      _isLoggedIn.value = true;
    }
  }

  /// Saves the JWT using SharedPreferences after a successful login.
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    _isLoggedIn.value = true;
  }

  /// Retrieves the stored JWT. Returns null if no token is found.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Deletes the JWT when the user logs out.
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    _isLoggedIn.value = false;
  }
}
