import 'package:defaultx/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DefaultX',

      // CORRECTED: Use the 'INITIAL' constant which holds the route name string.
      initialRoute: AppPages.INITIAL,

      // This part is correct.
      getPages: AppPages.routes,
    );
  }
}
