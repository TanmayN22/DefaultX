import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable data for real-time updates
  var totalApplications = 12456.obs;
  var defaultRiskDistribution = 15.0.obs;
  var averageCreditScore = 720.obs;
  var totalAlerts = 2.obs;

  var highRiskApplicants = <Map<String, dynamic>>[].obs;
  var anomalies = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() {
    // Load high-risk applicants with IDs
    highRiskApplicants.value = [
      {
        'id': 'USR001', // Added ID field
        'date': '2025-07-8',
        'creditScore': 580,
        'riskLevel': 'High',
      },
      {
        'id': 'USR002', // Added ID field
        'date': '2025-07-22',
        'creditScore': 620,
        'riskLevel': 'Medium',
      },
      {
        'id': 'USR003', // Added ID field
        'date': '2025-07-28',
        'creditScore': 550,
        'riskLevel': 'High',
      },
    ];

    // Load anomalies
    anomalies.value = [
      {
        'name': '1002329',
        'date': '2025-07-2',
        'type': 'Sudden Score Drop',
        'description': 'Credit score dropped by 150 points in the last month.',
      },
      {
        'name': '1002384',
        'date': '2025-07-12',
        'type': 'Unusual Application Pattern',
        'description': 'Multiple applications submitted within a short period.',
      },
    ];
  }
}
