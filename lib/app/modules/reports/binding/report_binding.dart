import 'package:defaultx/app/modules/reports/controller/report_controller.dart';
import 'package:get/get.dart';

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsController>(() => ReportsController());
  }
}
