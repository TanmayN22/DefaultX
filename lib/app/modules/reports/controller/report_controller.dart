import 'package:defaultx/app/data/models/applicant_model.dart';
import 'package:defaultx/app/data/repositories/applicant_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  final ApplicantRepository _repository = ApplicantRepository();
  
  final TextEditingController searchController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString searchError = ''.obs;
  final RxList<Applicant> searchResults = <Applicant>[].obs;
  final Rxn<Applicant> selectedApplicant = Rxn<Applicant>();
  
  List<Applicant> _allApplicants = [];

  @override
  void onInit() {
    super.onInit();
    _loadAllApplicants();
  }

  Future<void> _loadAllApplicants() async {
    try {
      _allApplicants = await _repository.getApplicants();
      print('Loaded ${_allApplicants.length} applicants for search');
    } catch (e) {
      print('Error loading applicants: $e');
    }
  }

  void searchApplicant() {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      searchError.value = 'Please enter an Applicant ID';
      return;
    }

    isLoading.value = true;
    searchError.value = '';
    searchResults.clear();
    selectedApplicant.value = null;

    try {
      // Search by ID (exact match)
      final results = _allApplicants.where((applicant) {
        final id = applicant.skIdCurr?.toInt().toString() ?? '';
        return id.contains(query);
      }).toList();

      if (results.isEmpty) {
        searchError.value = 'No applicant found with ID: $query';
      } else if (results.length == 1) {
        // If exact match, show report directly
        selectedApplicant.value = results.first;
      } else {
        // If multiple matches, show list
        searchResults.assignAll(results);
      }
    } catch (e) {
      searchError.value = 'Error searching for applicant: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void selectApplicant(Applicant applicant) {
    selectedApplicant.value = applicant;
    searchResults.clear();
  }

  void clearSelection() {
    selectedApplicant.value = null;
    searchResults.clear();
    searchError.value = '';
    searchController.clear();
  }

  String getApplicantStatus(Applicant applicant) {
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
