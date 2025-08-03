// File: lib/app/modules/reports/views/reports_view.dart
import 'package:flutter/material.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reports')),
      body: Center(
        child: Text(
          'Report Generation and Export',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
