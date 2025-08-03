// File: lib/app/data/repositories/applicant_repository.dart

import '../models/applicant_model.dart';
import '../providers/applicant_provider.dart';

class ApplicantRepository {
  // The repository has an instance of the provider to fetch the raw data.
  final ApplicantProvider _provider = ApplicantProvider();

  /// Fetches the list of applicants from the provider.
  ///
  /// This repository acts as the single source of truth for applicant data.
  /// The controller will call this method to get the data it needs.
  /// In a real app, you might add logic here for caching or combining
  /// data from multiple sources.
  Future<List<Applicant>> getApplicants() {
    return _provider.getApplicantsFromJson();
  }
}
