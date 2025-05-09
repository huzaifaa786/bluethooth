import 'package:bluetooth_sharing/views/bluetooth/bluetooth_controller.dart';
import 'package:get/get.dart';


class BluetoothBinding extends Bindings {
  final DeviceType type;
  BluetoothBinding(this.type);

  @override
  void dependencies() {
    Get.lazyPut(() => BluetoothController(type));
  }
}
