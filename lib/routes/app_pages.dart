import 'package:bluetooth_sharing/views/bluetooth/bluetooth_binding.dart';
import 'package:bluetooth_sharing/views/bluetooth/bluetooth_controller.dart';
import 'package:bluetooth_sharing/views/bluetooth/bluetooth_view.dart';
import 'package:bluetooth_sharing/views/home/home_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => HomeView()),
    GetPage(
      name: AppRoutes.sender,
      page: () => BluetoothView(deviceType: DeviceType.browser),
      binding: BluetoothBinding(DeviceType.browser),
    ),
    GetPage(
      name: AppRoutes.receiver,
      page: () => BluetoothView(deviceType: DeviceType.advertiser),
      binding: BluetoothBinding(DeviceType.advertiser),
    ),
  ];
}
