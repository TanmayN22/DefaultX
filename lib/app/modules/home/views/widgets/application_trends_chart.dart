import 'package:flutter/material.dart';

class ApplicationTrendsChart extends StatelessWidget {
  const ApplicationTrendsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Trends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),

          // Fixed Bar Chart - using Expanded to prevent overflow
          Container(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _buildBar('Jan', 80, Colors.blue[300]!)),
                Expanded(child: _buildBar('Feb', 120, Colors.blue[400]!)),
                Expanded(child: _buildBar('Mar', 90, Colors.blue[300]!)),
                Expanded(child: _buildBar('Apr', 128, Colors.blue[500]!)),
                Expanded(child: _buildBar('May', 110, Colors.blue[400]!)),
                Expanded(child: _buildBar('Jun', 103, Colors.blue[300]!)),
                Expanded(child: _buildBar('Jul', 119, Colors.blue[400]!)),
              ],
            ),
          ),

          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Applications',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                'Trend: -15%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String month, double height, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 2,
      ), // Small margin instead of SizedBox
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 16, // Reduced width to fit better
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 8),
          Text(
            month,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
            ), // Slightly smaller font
          ),
        ],
      ),
    );
  }
}
