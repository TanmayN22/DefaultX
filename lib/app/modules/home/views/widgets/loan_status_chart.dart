import 'package:defaultx/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanStatusChart extends GetView<HomeController> {
  const LoanStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        final approved = controller.loanStatusDistribution['Approved'] ?? 0;
        final potential =
            controller.loanStatusDistribution['Potential Defaulter'] ?? 0;
        final defaulted = controller.loanStatusDistribution['Defaulter'] ?? 0;
        final total = approved + potential + defaulted;

        if (total == 0) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Risk Status Distribution',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildLegendItem(Colors.green, 'Approved', approved, total),
                const SizedBox(width: 8),
                _buildLegendItem(Colors.orange, 'Potential', potential, total),
                const SizedBox(width: 8),
                _buildLegendItem(Colors.red, 'Defaulter', defaulted, total),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (approved > 0)
                  Expanded(
                    flex: approved,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            approved == total
                                ? BorderRadius.circular(5)
                                : const BorderRadius.horizontal(
                                  left: Radius.circular(5),
                                ),
                      ),
                    ),
                  ),
                if (potential > 0)
                  Expanded(
                    flex: potential,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius:
                            (approved == 0 && defaulted == 0)
                                ? BorderRadius.circular(5)
                                : BorderRadius.zero,
                      ),
                    ),
                  ),
                if (defaulted > 0)
                  Expanded(
                    flex: defaulted,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            defaulted == total
                                ? BorderRadius.circular(5)
                                : const BorderRadius.horizontal(
                                  right: Radius.circular(5),
                                ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildLegendItem(Color color, String title, int value, int total) {
    final percentage = total > 0 ? (value / total * 100) : 0;
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              '$title: ${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 9),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
