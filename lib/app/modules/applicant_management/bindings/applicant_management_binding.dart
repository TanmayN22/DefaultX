// File: lib/app/modules/applicant_management/bindings/applicant_management_binding.dart
import 'package:get/get.dart';
import '../controllers/applicant_management_controller.dart';

class ApplicantManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicantManagementController>(
      () => ApplicantManagementController(),
    );
  }
}
