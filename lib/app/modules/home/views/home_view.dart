import 'package:defaultx/app/core/widgets/common_nav_bar.dart';
import 'package:defaultx/app/core/widgets/kochikar_tech_text.dart';
import 'package:defaultx/app/modules/home/views/widgets/income_type_chart.dart';
import 'package:defaultx/app/modules/home/views/widgets/loan_status_chart.dart';
import 'package:defaultx/app/modules/home/views/widgets/metric_card.dart';
import 'package:defaultx/app/modules/home/views/widgets/recent_applications_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.compactSimpleCurrency(
      locale: 'en_US',
    );
    final numberFormatter = NumberFormat.compact();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: const CommonAppBar(currentPage: 'Home'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 80,
            right: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Credit Risk Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Top Row Metric Cards
              SizedBox(
                height: 180,
                child: Row(
                  children: [
                    Expanded(
                      child: MetricCard(
                        title: 'Total Applications',
                        value: numberFormatter.format(
                          controller.totalApplications.value,
                        ),
                        change: '',
                        isPositive: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MetricCard(
                        title: 'Default Rate',
                        value:
                            '${controller.defaultRate.value.toStringAsFixed(1)}%',
                        change: 'Target: <10%',
                        isPositive: controller.defaultRate.value < 10,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MetricCard(
                        title: 'Total Credit Issued',
                        value: currencyFormatter.format(
                          controller.totalCreditAmount.value,
                        ),
                        change: '',
                        isPositive: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MetricCard(
                        title: 'Avg Credit Amount',
                        value: currencyFormatter.format(
                          controller.avgCreditAmount.value,
                        ),
                        change: '',
                        isPositive: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Second Row Metric Cards
              SizedBox(
                height: 180,
                child: Row(
                  children: [
                    Expanded(
                      child: MetricCard(
                        title: 'Avg Income',
                        value: currencyFormatter.format(
                          controller.avgIncome.value,
                        ),
                        change: '',
                        isPositive: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MetricCard(
                        title: 'Approved',
                        value: numberFormatter.format(
                          controller.approvedApplicants.value,
                        ),
                        change:
                            '${(controller.totalApplications.value > 0 ? (controller.approvedApplicants.value / controller.totalApplications.value * 100) : 0).toStringAsFixed(1)}%',
                        isPositive: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MetricCard(
                        title: 'High Risk',
                        value: numberFormatter.format(
                          controller.applicantsWithHighRisk.value,
                        ),
                        change:
                            '${(controller.totalApplications.value > 0 ? (controller.applicantsWithHighRisk.value / controller.totalApplications.value * 100) : 0).toStringAsFixed(1)}%',
                        isPositive: false,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MetricCard(
                        title: 'Avg Risk Score',
                        value: controller.avgRiskScore.value.toStringAsFixed(1),
                        change: 'Out of 50',
                        isPositive: controller.avgRiskScore.value < 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Main Content Area
              SizedBox(
                height: 380,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column - Charts
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Loan Status Distribution - Fixed size
                          Container(
                            height: 140,
                            child: const LoanStatusChart(),
                          ),
                          const SizedBox(height: 20),
                          // Applicants by Income Type - Takes remaining space
                          Expanded(child: const IncomeTypeChart()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Middle Column - More Charts
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(child: _buildContractTypeChart()),
                          const SizedBox(height: 20),
                          Expanded(child: _buildFamilyStatusChart()),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Right Column - Applications
                    Expanded(flex: 3, child: const RecentApplicationsList()),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bottom Row - Education, Risk Score, and Top Occupations
              SizedBox(
                height: 380,
                child: Row(
                  children: [
                    Expanded(flex: 2, child: _buildEducationChart()),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: _buildRiskChart()),
                    const SizedBox(width: 20),
                    Expanded(flex: 3, child: _buildTopOccupationsChart()),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      persistentFooterButtons: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: KochikarTech()),
        ),
      ],
    );
  }

  Widget _buildRiskChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Average Risk Score',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: CircularProgressIndicator(
                          value: (controller.avgRiskScore.value / 50).clamp(
                            0.0,
                            1.0,
                          ),
                          strokeWidth: 12,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation(
                            controller.avgRiskScore.value < 30
                                ? Colors.green
                                : controller.avgRiskScore.value < 40
                                ? Colors.orange
                                : Colors.red,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.avgRiskScore.value.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Text(
                            'out of 50',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEducationChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final distribution = controller.educationDistribution;
        final total = distribution.values.fold(0, (sum, count) => sum + count);

        if (total == 0) return const SizedBox.shrink();

        final sortedEntries =
            distribution.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Education Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      sortedEntries.take(5).map((entry) {
                        return _buildLargeBar(
                          entry.key,
                          entry.value,
                          total,
                          Colors.orange.shade300,
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLargeBar(String title, int count, int total, Color color) {
    final percentage = total > 0 ? (count / total) : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ($count)',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 12,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Container(
                    height: 12,
                    width: constraints.maxWidth * percentage,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContractTypeChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final distribution = controller.contractTypeDistribution;
        final total = distribution.values.fold(0, (sum, count) => sum + count);

        if (total == 0) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contract Type Distribution',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    distribution.entries.map((entry) {
                      return _buildBar(
                        entry.key,
                        entry.value,
                        total,
                        Colors.purple.shade300,
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildFamilyStatusChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final distribution = controller.familyStatusDistribution;
        final total = distribution.values.fold(0, (sum, count) => sum + count);

        if (total == 0) return const SizedBox.shrink();

        final sortedEntries =
            distribution.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Family Status Distribution',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      sortedEntries.take(4).map((entry) {
                        return _buildBar(
                          entry.key,
                          entry.value,
                          total,
                          Colors.teal.shade300,
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTopOccupationsChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final distribution = controller.occupationDistribution;
        final total = distribution.values.fold(0, (sum, count) => sum + count);

        if (total == 0) return const SizedBox.shrink();

        final sortedEntries =
            distribution.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Occupations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      sortedEntries.take(10).map((entry) {
                        final percentage =
                            total > 0 ? (entry.value / total * 100) : 0;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${percentage.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBar(String title, int count, int total, Color color) {
    final percentage = total > 0 ? (count / total) : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title ($count)', style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 8,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: constraints.maxWidth * percentage,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
