import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

enum DeviceType { advertiser, browser }

class BluetoothController extends GetxController {
  final DeviceType deviceType;

  BluetoothController(this.deviceType);

  final devices = <Device>[].obs;
  final connectedDevices = <Device>[].obs;

  late NearbyService nearbyService;
  late StreamSubscription stateSub;
  late StreamSubscription dataSub;

  @override
  void onInit() {
    super.onInit();
    initNearby();
  }

  @override
  void onClose() {
    stateSub.cancel();
    dataSub.cancel();
    nearbyService.stopBrowsingForPeers();
    nearbyService.stopAdvertisingPeer();
    super.onClose();
  }

  Future<void> initNearby() async {
    await _requestPermissions();

    nearbyService = NearbyService();
    final deviceName = await _getDeviceName();

    await nearbyService.init(
      serviceType: 'mpconn',
      deviceName: deviceName,
      strategy: Strategy.P2P_CLUSTER,
      callback: (isRunning) {
        if (isRunning) {
          if (deviceType == DeviceType.browser) {
            nearbyService.startBrowsingForPeers();
          } else {
            nearbyService.startAdvertisingPeer();
          }
        }
      },
    );

    stateSub = nearbyService.stateChangedSubscription(callback: (deviceList) {
      devices.assignAll(deviceList);
      connectedDevices.assignAll(
        deviceList.where((d) => d.state == SessionState.connected),
      );
    });

    dataSub = nearbyService.dataReceivedSubscription(callback: (data) {
      if (deviceType == DeviceType.advertiser) {
        showToast("Received: ${data['message']}", context: Get.context!);
      }
    });
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();
    } else {
      await [Permission.bluetooth, Permission.locationWhenInUse].request();
    }
  }

  Future<String> _getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.localizedModel ?? 'iOS Device';
    }
    return 'Unknown Device';
  }

  void connectOrDisconnect(Device device) {
    if (device.state == SessionState.connected) {
      nearbyService.disconnectPeer(deviceID: device.deviceId);
    } else if (device.state == SessionState.notConnected) {
      nearbyService.invitePeer(
        deviceID: device.deviceId,
        deviceName: device.deviceName,
      );
    }
  }

  void sendMessageToAll(String msg) {
    for (var device in connectedDevices) {
      nearbyService.sendMessage(device.deviceId, msg);
    }
  }
}
