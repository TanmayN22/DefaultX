import 'package:get/get.dart';
import '../controllers/applicant_management_controller.dart';
import '../../../data/repositories/applicant_repository.dart';

class ApplicantManagementBinding extends Bindings {
  @override
  void dependencies() {
    // First put the repository
    Get.lazyPut<ApplicantRepository>(() => ApplicantRepository());

    // Then put the controller with the repository dependency
    Get.lazyPut<ApplicantManagementController>(
      () => ApplicantManagementController(),
    );
  }
}
