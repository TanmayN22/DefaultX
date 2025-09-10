import 'dart:convert';
import 'package:defaultx/app/data/models/applicant_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // --- Raw Data & Loading State ---
  final RxList<Applicant> applications = <Applicant>[].obs;
  final RxBool isLoading = true.obs;

  // --- Existing Metrics ---
  final RxInt totalApplications = 0.obs;
  final RxDouble defaultRate = 0.0.obs;
  final RxDouble totalCreditAmount = 0.0.obs;
  final RxInt applicantsWithHighRisk = 0.obs;

  // --- New Metrics ---
  final RxDouble avgCreditAmount = 0.0.obs;
  final RxDouble avgIncome = 0.0.obs;
  final RxDouble avgRiskScore = 0.0.obs;
  final RxInt approvedApplicants = 0.obs;
  final RxInt potentialDefaulters = 0.obs;
  final RxInt defaulters = 0.obs;

  // --- Chart and List Data ---
  final RxMap<String, int> loanStatusDistribution = <String, int>{}.obs;
  final RxMap<String, int> incomeTypeDistribution = <String, int>{}.obs;
  final RxMap<String, int> educationDistribution = <String, int>{}.obs;
  final RxMap<String, int> contractTypeDistribution = <String, int>{}.obs;
  final RxMap<String, int> familyStatusDistribution = <String, int>{}.obs;
  final RxMap<String, int> occupationDistribution = <String, int>{}.obs;
  final RxMap<String, int> riskDistribution = <String, int>{}.obs;
  final RxList<Applicant> recentApplications = <Applicant>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadApplicationData();
  }

  Future<void> loadApplicationData() async {
    try {
      isLoading.value = true;
      print("Starting to load JSON data...");

      final String jsonString = await rootBundle.loadString(
        'assets/data/application_train.json',
      );
      print("JSON loaded, length: ${jsonString.length}");

      final List<dynamic> jsonData = json.decode(jsonString);
      print("Parsed ${jsonData.length} records");

      final List<Applicant> data = jsonData.map((json) => Applicant.fromJson(json)).toList();
      
      // Filter out invalid applicants (same as ApplicantManagement)
      final validData = data.where((app) => (app.skIdCurr ?? 0) != 0).toList();
      applications.assignAll(validData);

      print("Applications assigned: ${applications.length}");
      processData();
    } catch (e) {
      print("Error loading application data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void processData() {
    if (applications.isEmpty) {
      print("No applications to process");
      return;
    }

    print("Processing ${applications.length} applications");

    // --- Calculate Key Metrics ---
    totalApplications.value = applications.length;

    // Calculate risk-based status using EXACT same logic as ApplicantManagementController
    int approved = 0;
    int potentialDefault = 0;
    int defaulted = 0;
    double totalRiskScore = 0.0;
    int validRiskCount = 0;

    for (var app in applications) {
      final riskProbabilityValue = (app.extSource2 ?? 0.2) * 50;
      totalRiskScore += riskProbabilityValue;
      validRiskCount++;

      // Use EXACT same logic as ApplicantManagement
      if (riskProbabilityValue >= 40) {
        defaulted++;
      } else if (riskProbabilityValue >= 30 && riskProbabilityValue < 40) {
        potentialDefault++;
      } else {
        approved++;
      }
    }

    approvedApplicants.value = approved;
    potentialDefaulters.value = potentialDefault;
    defaulters.value = defaulted;
    applicantsWithHighRisk.value = defaulted + potentialDefault;

    // Calculate default rate based on risk score
    defaultRate.value = totalApplications.value > 0 
        ? (defaulters.value / totalApplications.value) * 100 
        : 0.0;

    // Calculate average risk score
    avgRiskScore.value = validRiskCount > 0 ? totalRiskScore / validRiskCount : 0.0;

    // Calculate total and average credit
    totalCreditAmount.value = applications.fold(0.0, (sum, app) => sum + (app.amtCredit ?? 0.0));
    avgCreditAmount.value = totalApplications.value > 0 
        ? totalCreditAmount.value / totalApplications.value 
        : 0.0;

    // Calculate average income
    final totalIncome = applications.fold(0.0, (sum, app) => sum + (app.amtIncomeTotal ?? 0.0));
    avgIncome.value = totalApplications.value > 0 
        ? totalIncome / totalApplications.value 
        : 0.0;

    // --- Process Data for Charts ---
    _calculateDistributions();

    print("Final metrics - Total: ${totalApplications.value}, Default Rate: ${defaultRate.value}%, Avg Risk Score: ${avgRiskScore.value}");
    print("Breakdown - Approved: ${approvedApplicants.value}, Potential: ${potentialDefaulters.value}, Defaulters: ${defaulters.value}");
    
    // Force UI updates
    avgRiskScore.refresh();
    approvedApplicants.refresh(); 
    defaulters.refresh();
    applicantsWithHighRisk.refresh();
    defaultRate.refresh();
    totalApplications.refresh();

    debugData();
  }

  void _calculateDistributions() {
    // Risk-based Status Distribution for Loan Status Chart
    loanStatusDistribution.assignAll({
      'Approved': approvedApplicants.value,
      'Potential Defaulter': potentialDefaulters.value,
      'Defaulter': defaulters.value,
    });

    // Risk Score Distribution
    int lowRisk = 0;
    int mediumRisk = 0;
    int highRisk = 0;

    for (var app in applications) {
      final riskScore = (app.extSource2 ?? 0.2) * 50;
      if (riskScore < 30) {
        lowRisk++;
      } else if (riskScore < 40) {
        mediumRisk++;
      } else {
        highRisk++;
      }
    }

    riskDistribution.assignAll({
      'Low Risk (<30)': lowRisk,
      'Medium Risk (30-40)': mediumRisk,
      'High Risk (≥40)': highRisk,
    });

    // Income Type Distribution
    final incomeMap = <String, int>{};
    for (var app in applications) {
      final incomeType = app.nameIncomeType ?? 'Unknown';
      incomeMap[incomeType] = (incomeMap[incomeType] ?? 0) + 1;
    }
    incomeTypeDistribution.assignAll(incomeMap);

    // Education Distribution
    final educationMap = <String, int>{};
    for (var app in applications) {
      final education = app.nameEducationType ?? 'Unknown';
      educationMap[education] = (educationMap[education] ?? 0) + 1;
    }
    educationDistribution.assignAll(educationMap);

    // Contract Type Distribution
    final contractMap = <String, int>{};
    for (var app in applications) {
      final contract = app.nameContractType ?? 'Unknown';
      contractMap[contract] = (contractMap[contract] ?? 0) + 1;
    }
    contractTypeDistribution.assignAll(contractMap);

    // Family Status Distribution
    final familyMap = <String, int>{};
    for (var app in applications) {
      final family = app.nameFamilyStatus ?? 'Unknown';
      familyMap[family] = (familyMap[family] ?? 0) + 1;
    }
    familyStatusDistribution.assignAll(familyMap);

    // Occupation Distribution
    final occupationMap = <String, int>{};
    for (var app in applications) {
      final occupation = app.occupationType ?? 'Unknown';
      occupationMap[occupation] = (occupationMap[occupation] ?? 0) + 1;
    }
    occupationDistribution.assignAll(occupationMap);

    // Get most recent applications (first 5 as proxy)
    recentApplications.assignAll(applications.take(5).toList());
  }

  void debugData() {
    if (applications.isNotEmpty) {
      print("=== DEBUG: Risk-based Analysis ===");
      print("Total Applications: ${totalApplications.value}");
      print("Approved: ${approvedApplicants.value}");
      print("Potential Defaulters: ${potentialDefaulters.value}"); 
      print("Defaulters: ${defaulters.value}");
      print("Default Rate: ${defaultRate.value}%");
      print("Average Risk Score: ${avgRiskScore.value}");

      // Check if risk calculation is actually working
      final sampleApps = applications.take(10);
      int testApproved = 0, testPotential = 0, testDefaulted = 0;
      
      for (var app in sampleApps) {
        final riskScore = (app.extSource2 ?? 0.2) * 50;
        final status = _getApplicantStatus(app);
        print("ID: ${app.skIdCurr}, ExtSource2: ${app.extSource2}, Risk Score: ${riskScore.toStringAsFixed(1)}, Status: $status");
        
        if (riskScore >= 40) testDefaulted++;
        else if (riskScore >= 30) testPotential++; 
        else testApproved++;
      }
      
      print("Sample breakdown - Approved: $testApproved, Potential: $testPotential, Defaulters: $testDefaulted");
    }
  }

  // EXACT same method as ApplicantManagementController
  String _getApplicantStatus(Applicant applicant) {
    final riskProbabilityValue = (applicant.extSource2 ?? 0.2) * 50;
    if (riskProbabilityValue >= 40) {
      return 'Defaulter';
    } else if (riskProbabilityValue >= 30 && riskProbabilityValue < 40) {
      return 'Potential Defaulter';
    } else {
      return 'Approved';
    }
  }
}
