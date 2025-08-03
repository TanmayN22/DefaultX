import 'package:defaultx/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HighRiskApplicantsTable extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Applicant ID', style: TextStyle(fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Application Date', style: TextStyle(fontWeight: FontWeight.w600))),
                Expanded(flex: 1, child: Text('Credit Score', style: TextStyle(fontWeight: FontWeight.w600))),
                Expanded(flex: 1, child: Text('Risk Level', style: TextStyle(fontWeight: FontWeight.w600))),
                Expanded(flex: 1, child: Text('Action', style: TextStyle(fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          Divider(height: 1),
          // Table Rows
          Obx(() => Column(
            children: controller.highRiskApplicants.map((applicant) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(applicant['name'])),
                    Expanded(flex: 2, child: Text(applicant['date'])),
                    Expanded(flex: 1, child: Text(applicant['creditScore'].toString())),
                    Expanded(flex: 1, child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: applicant['riskLevel'] == 'High' ? Colors.red.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        applicant['riskLevel'],
                        style: TextStyle(
                          color: applicant['riskLevel'] == 'High' ? Colors.red : Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
                    Expanded(flex: 1, child: TextButton(
                      onPressed: () {},
                      child: Text('View Details', style: TextStyle(color: Colors.blue)),
                    )),
                  ],
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}
