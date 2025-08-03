// lib/app/modules/applicant_management/controllers/applicant_management_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/applicant_model.dart';
import '../../../data/repositories/applicant_repository.dart';

class ApplicantManagementController extends GetxController {
  final ApplicantRepository _repository = ApplicantRepository();

  // --- STATE MANAGEMENT ---
  final isLoading = true.obs;
  final _allApplicants = <Applicant>[].obs; // The master list
  final filteredApplicants =
      <Applicant>[].obs; // The list displayed in the table
  final searchController = TextEditingController();

  final sortColumnIndex = 1.obs;
  final isAscending = true.obs;

  // State for the new filters
  final selectedLoanType = Rxn<String>();
  final selectedStatus = Rxn<String>();

  // Lists to populate the filter dropdowns
  final loanTypes = <String>[].obs;
  final statuses = <String>['Approved', 'Potential Defaulter', 'Defaulter'].obs;

  // --- LIFECYCLE HOOKS ---
  @override
  void onInit() {
    super.onInit();
    fetchApplicants();
    // <-- MODIFIED: Listeners that caused instant filtering are now removed.
    // The filtering logic will now only be triggered by the "Apply Filter" button.
  }

  // --- BUSINESS LOGIC / ACTIONS ---

  /// Fetches, cleans, and prepares the applicant data.
  Future<void> fetchApplicants() async {
    try {
      isLoading.value = true;
      var applicants = await _repository.getApplicants();

      // Filter out applicants with an ID of 0 or any invalid ID
      applicants = applicants.where((app) => app.skIdCurr != 0).toList();

      _allApplicants.assignAll(applicants);

      // Populate the loan types list for the filter dropdown
      final uniqueLoanTypes =
          applicants
              .map((app) => app.nameContractType)
              .where((type) => type != null)
              .toSet();
      loanTypes.assignAll(uniqueLoanTypes.toList().cast<String>());

      applyFiltersAndSearch(); // <-- MODIFIED: Apply initial filters (shows all)
    } catch (e) {
      Get.snackbar('Error', 'Could not load applicant data.');
      // ignore: avoid_print
      print("Error fetching applicants: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// <-- MODIFIED: Renamed method. It now combines search and dropdown filters
  /// and is only called when the user presses the "Apply Filter" button.
  void applyFiltersAndSearch() {
    final query = searchController.text.toLowerCase();

    List<Applicant> tempFiltered =
        _allApplicants.where((applicant) {
          // Search logic - now only searches by ID when the button is pressed.
          final searchMatch =
              query.isEmpty ||
              applicant.skIdCurr.toString().toLowerCase().contains(query);

          // Loan Type filter logic
          final loanTypeMatch =
              selectedLoanType.value == null ||
              applicant.nameContractType == selectedLoanType.value;

          // Status filter logic (using your specific calculation)
          final status = _getApplicantStatus(applicant);
          final statusMatch =
              selectedStatus.value == null || status == selectedStatus.value;

          return searchMatch && loanTypeMatch && statusMatch;
        }).toList();

    filteredApplicants.assignAll(tempFiltered);
    // Re-apply the current sort order to the newly filtered list
    onSort(sortColumnIndex.value, isAscending.value);
  }

  void onSort(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    isAscending.value = ascending;

    filteredApplicants.sort((a, b) {
      int result = 0;
      switch (columnIndex) {
        case 0: // Loan Type
          result = (a.nameContractType ?? '').compareTo(
            b.nameContractType ?? '',
          );
          break;
        case 1: // Application ID
          result = a.skIdCurr.compareTo(b.skIdCurr);
          break;
        case 2: // Risk Probability
          final riskA = (a.extSource2 ?? 0.2) * 50;
          final riskB = (b.extSource2 ?? 0.2) * 50;
          result = riskA.compareTo(riskB);
          break;
        case 3: // Status
          result = _getApplicantStatus(a).compareTo(_getApplicantStatus(b));
          break;
      }
      return ascending ? result : -result;
    });
  }

  /// Helper function to determine an applicant's status based on your business rules.
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
