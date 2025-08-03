import 'package:get/get.dart';
import '../../../core/services/api_service.dart';

/// HomeController
///
/// Fetches and manages the data for the home screen after a user is logged in.
class HomeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  // Reactive variables to hold the user's data and loading state.
  // The UI will automatically update when these change.
  final userEmail = ''.obs;
  final isLoading = true.obs; // Start with loading true

  /// Called by GetX automatically when the controller is initialized.
  @override
  void onInit() {
    super.onInit();
    // Fetch the user's profile as soon as the home screen loads.
    fetchUserProfile();
  }

  /// Fetches user data from the protected API route.
  void fetchUserProfile() async {
    try {
      isLoading.value = true;
      // Call the method on our ApiService. The token is added automatically.
      final response = await _apiService.getProtectedData();

      if (response.statusCode == 200) {
        // Extract the email from the nested 'user' object in the API response.
        userEmail.value = response.data['user']['email'];
      }
    } catch (e) {
      print('Error fetching profile: $e');
      Get.snackbar('Error', 'Could not fetch user profile.');
    } finally {
      isLoading.value = false;
    }
  }
}
