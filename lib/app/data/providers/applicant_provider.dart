// File: lib/app/data/providers/applicant_provider.dart

import 'package:flutter/services.dart' show rootBundle;
import '../models/applicant_model.dart';

class ApplicantProvider {
  /// Reads the application_train.json file from the assets folder and
  /// parses it into a list of Applicant models.
  Future<List<Applicant>> getApplicantsFromJson() async {
    try {
      // Load the raw JSON string from the asset bundle
      String jsonString = await rootBundle.loadString(
        'assets/data/application_train.json',
      );
      jsonString = jsonString.replaceAll('NaN', 'null');
      // Use the helper function in the model to parse the JSON string
      return applicantFromJson(jsonString);
    } catch (e) {
      print("Error reading or parsing applicant JSON: $e");
      // Return an empty list in case of an error to prevent the app from crashing.
      return [];
    }
  }
}
