import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? currentPage; // To highlight the active page

  const CommonAppBar({Key? key, this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'DefaultX',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        _buildNavButton('Dashboard', '/dashboard'),
        _buildNavButton('Applications', '/applications'),
        _buildNavButton('Reports', '/reports'),
        _buildNavButton('Settings', '/settings'),
        CircleAvatar(
          // backgroundImage: AssetImage('assets/profile.jpg'),
          child: Icon(Icons.person), // Placeholder until you add profile image
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildNavButton(String title, String route) {
    bool isActive = currentPage == title;
    
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.black45,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
