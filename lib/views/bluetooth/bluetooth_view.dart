import 'package:bluetooth_sharing/views/bluetooth/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

class BluetoothView extends StatelessWidget {
  final DeviceType deviceType;

  BluetoothView({required this.deviceType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BluetoothController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(deviceType == DeviceType.browser ? 'Sender' : 'Receiver'),
        actions: deviceType == DeviceType.browser
            ? [
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final msgCtrl = TextEditingController();
                    Get.defaultDialog(
                      title: "Send Message",
                      content: TextField(controller: msgCtrl),
                      confirm: TextButton(
                        onPressed: () {
                          controller.sendMessageToAll(msgCtrl.text);
                          Get.back();
                        },
                        child: Text("Send"),
                      ),
                      cancel: TextButton(
                        onPressed: () => Get.back(),
                        child: Text("Cancel"),
                      ),
                    );
                  },
                )
              ]
            : [],
      ),
      body: Obx(() {
        final list = deviceType == DeviceType.browser
            ? controller.devices
            : controller.connectedDevices;

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) {
            final device = list[i];
            return ListTile(
              title: Text(device.deviceName),
              subtitle: Text(device.state.toString()),
              trailing: ElevatedButton(
                onPressed: () => controller.connectOrDisconnect(device),
                child: Text(
                  device.state == SessionState.connected
                      ? 'Disconnect'
                      : 'Connect',
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
