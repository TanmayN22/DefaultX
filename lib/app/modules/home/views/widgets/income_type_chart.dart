import 'package:defaultx/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeTypeChart extends GetView<HomeController> {
  const IncomeTypeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final distribution = controller.incomeTypeDistribution;
        final total = distribution.values.fold(0, (sum, count) => sum + count);
        if (total == 0) return const SizedBox.shrink();

        // Sort entries for consistent display
        final sortedEntries =
            distribution.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));

        // In your income_type_chart.dart, replace the Column with:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Applicants by Income Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ...sortedEntries.take(6).map((entry) {
                // Limit to 6 items
                return _buildBar(
                  entry.key,
                  entry.value,
                  total,
                  Colors.blue.shade300,
                );
              }).toList(),
            ],
          ),
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
          Text('$title ($count)', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 10,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: constraints.maxWidth * percentage,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
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
