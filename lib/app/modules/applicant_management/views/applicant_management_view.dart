// File: lib/app/modules/applicant_management/views/applicant_management_view.dart
import 'package:flutter/material.dart';

class ApplicantManagementView extends StatelessWidget {
  const ApplicantManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Applicant Management')),
      body: Center(
        child: Text(
          'Applicant List, Filters, Risk Tags',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
