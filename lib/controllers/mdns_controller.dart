import 'package:get/get.dart';
import '../services/mdns_service.dart';
import '../services/mdns_discovery.dart';

class MDNSController extends GetxController {
  // final MDNSService _mdnsService = MDNSService();
  final MDNSDiscovery _mdnsDiscovery = MDNSDiscovery();
  var availableDevices = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // _mdnsService.startAnnouncing();
    _mdnsDiscovery.discoverServices((String address, int port) {
      availableDevices.add('$address:$port');
    });
  }

  @override
  void onClose() {
    // _mdnsService.stopAnnouncing();
    _mdnsDiscovery.stopDiscovery();
    super.onClose();
  }
}