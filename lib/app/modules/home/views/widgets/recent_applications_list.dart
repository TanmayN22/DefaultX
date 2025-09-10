import 'package:defaultx/app/data/models/applicant_model.dart';
import 'package:defaultx/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecentApplicationsList extends GetView<HomeController> {
  const RecentApplicationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Applications',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Divider(height: 24),
          Obx(
            () => Column(
              children: controller.recentApplications
                  .map((app) => _buildApplicantTile(app, currencyFormatter))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantTile(
      Applicant applicant, NumberFormat currencyFormatter) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Applicant ID: ${applicant.skIdCurr.toInt()}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                applicant.nameContractType ?? 'N/A',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
          Text(
            currencyFormatter.format(applicant.amtCredit ?? 0),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
