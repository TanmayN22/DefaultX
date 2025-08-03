// File: lib/app/modules/dashboard/views/dashboard_view.dart
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    // Each page has its own AppBar, which is a good practice for desktop apps.
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Text(
          'Main Dashboard with Charts and KPIs',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
