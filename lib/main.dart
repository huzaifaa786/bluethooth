import 'package:bluetooth_sharing/views/file_sharing_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bluetooth_Sharing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ), 
    // initialBinding: HomeBinding(),
      home: FileSharingHome(),
      // getPages: AppPages.pages,
    );
  }
}

