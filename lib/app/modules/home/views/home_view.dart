import 'package:defaultx/app/core/widgets/common_nav_bar.dart';
import 'package:defaultx/app/modules/home/views/widgets/anomaly_detection_table.dart';
import 'package:defaultx/app/modules/home/views/widgets/application_trends_chart.dart';
import 'package:defaultx/app/modules/home/views/widgets/metric_card.dart';
import 'package:defaultx/app/modules/home/views/widgets/high_risk_chart.dart';
import 'package:defaultx/app/modules/home/views/widgets/risk_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(currentPage: 'Dashboard'),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 24, bottom: 24, left: 100, right: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Metrics Row
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    title: 'Total Applications',
                    value: '12,456',
                    change: '+12%',
                    isPositive: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MetricCard(
                    title: 'Default Risk Distribution',
                    value: '15%',
                    change: '-5%',
                    isPositive: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MetricCard(
                    title: 'Average Credit Score',
                    value: '720',
                    change: '+2%',
                    isPositive: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MetricCard(
                    title: 'Alerts',
                    value: '2',
                    change: '+10%',
                    isPositive: false,
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Risk Assessment Section
            Text(
              'Risk Assessment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                RiskChart(
                  title: 'Credit Score Distribution',
                  value: '720',
                  subtitle: 'Last 30 Days +2%',
                ),
                SizedBox(width: 16),
                Expanded(flex: 1, child: ApplicationTrendsChart()),
              ],
            ),

            SizedBox(height: 32),

            // High-Risk Applicants Table
            Text(
              'High-Risk Applicants',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            HighRiskApplicantsTable(),

            SizedBox(height: 32),

            // Anomaly Detection Table
            Text(
              'Anomaly Detection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            AnomalyDetectionTable(),
          ],
        ),
      ),
    );
  }
}
