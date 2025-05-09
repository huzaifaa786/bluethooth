// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale('en', 'US'),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bluetooth Sharing',
        initialRoute: AppRoutes.home,
        getPages: AppPages.pages,
      ),
    );
  }
}
