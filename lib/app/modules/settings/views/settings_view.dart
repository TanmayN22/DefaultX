import 'package:defaultx/app/core/widgets/common_nav_bar.dart';
import 'package:defaultx/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(currentPage: 'Settings'),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Container(
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
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile Settings'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Security'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.LOGIN);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
