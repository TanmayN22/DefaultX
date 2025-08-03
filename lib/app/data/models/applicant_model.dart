// File: lib/app/data/models/applicant_model.dart

import 'dart:convert';

// This is a helper function that can convert a raw JSON string
// directly into a list of Applicant objects.
List<Applicant> applicantFromJson(String str) =>
    List<Applicant>.from(json.decode(str).map((x) => Applicant.fromJson(x)));

/// A data model class that represents a single applicant from the JSON data.
///
/// Using final properties makes the model immutable, which is a good practice.
/// Nullable types (?) are used for fields that might be missing or null in the JSON.
class Applicant {
  final double skIdCurr;
  final int target;
  final String? nameContractType;
  final double? amtIncomeTotal;
  final double? amtCredit;
  final double? amtAnnuity;
  final double? amtGoodsPrice;
  final String? nameIncomeType;
  final String? nameEducationType;
  final String? nameFamilyStatus;
  final int? daysBirth;
  final int? daysEmployed;
  final String? occupationType;
  final String? organizationType;
  final double? extSource2;

  Applicant({
    required this.skIdCurr,
    required this.target,
    this.nameContractType,
    this.amtIncomeTotal,
    this.amtCredit,
    this.amtAnnuity,
    this.amtGoodsPrice,
    this.nameIncomeType,
    this.nameEducationType,
    this.nameFamilyStatus,
    this.daysBirth,
    this.daysEmployed,
    this.occupationType,
    this.organizationType,
    this.extSource2,
  });

  /// A factory constructor that creates an Applicant instance from a JSON map.
  ///
  /// This is the standard way to handle JSON deserialization in Dart.
  /// It safely handles type conversions and potential null values from the JSON file.
  factory Applicant.fromJson(Map<String, dynamic> json) {
    // Helper function to safely parse numbers that might be null or in string format.
    T? _safeParse<T>(dynamic value) {
      if (value == null) return null;
      if (T == int) return int.tryParse(value.toString()) as T?;
      if (T == double) return double.tryParse(value.toString()) as T?;
      return value as T?;
    }

    return Applicant(
      skIdCurr: _safeParse<double>(json["SK_ID_CURR"]) ?? 0,
      target: _safeParse<int>(json["TARGET"]) ?? 0,
      nameContractType: json["NAME_CONTRACT_TYPE"],
      amtIncomeTotal: _safeParse<double>(json["AMT_INCOME_TOTAL"]),
      amtCredit: _safeParse<double>(json["AMT_CREDIT"]),
      amtAnnuity: _safeParse<double>(json["AMT_ANNUITY"]),
      amtGoodsPrice: _safeParse<double>(json["AMT_GOODS_PRICE"]),
      nameIncomeType: json["NAME_INCOME_TYPE"],
      nameEducationType: json["NAME_EDUCATION_TYPE"],
      nameFamilyStatus: json["NAME_FAMILY_STATUS"],
      daysBirth: _safeParse<int>(json["DAYS_BIRTH"]),
      daysEmployed: _safeParse<int>(json["DAYS_EMPLOYED"]),
      occupationType: json["OCCUPATION_TYPE"],
      organizationType: json["ORGANIZATION_TYPE"],
      extSource2: _safeParse<double>(json["EXT_SOURCE_2"]),
    );
  }
}
