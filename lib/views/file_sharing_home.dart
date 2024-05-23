import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/file_controller.dart';
import '../controllers/mdns_controller.dart';

class FileSharingHome extends StatelessWidget {
  final FileController fileController = Get.put(FileController());
  final MDNSController mdnsController = Get.put(MDNSController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Sharing App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (fileController.selectedFile.value != null) {
                return Text('Selected file: ${fileController.selectedFile.value!.path}');
              } else {
                return Text('No file selected');
              }
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fileController.pickFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            Obx(() {
              return DropdownButton<String>(
                hint: Text('Select Device'),
                value: fileController.selectedFile.value != null ? fileController.selectedFile.value!.path : null,
                onChanged: (String? newValue) {
                  fileController.selectedFile.value = newValue != null ? File(newValue) : null;
                },
                items: mdnsController.availableDevices.map<DropdownMenuItem<String>>((String device) {
                  return DropdownMenuItem<String>(
                    value: device,
                    child: Text(device),
                  );
                }).toList(),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final selectedDevice = mdnsController.availableDevices.isNotEmpty ? mdnsController.availableDevices[0] : null;
                if (selectedDevice != null && fileController.selectedFile.value != null) {
                  final parts = selectedDevice.split(':');
                  final address = parts[0];
                  final port = int.parse(parts[1]);
                  fileController.sendFile(address, port);
                }
              },
              child: Text('Send File'),
            ),
          ],
        ),
      ),
    );
  }
}