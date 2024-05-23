import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../services/file_client.dart';
import '../services/file_server.dart';

class FileController extends GetxController {
  var selectedFile = Rx<File?>(null);
  final FileServer _server = FileServer();
  final FileClient _client = FileClient();

  @override
  void onInit() {
    super.onInit();
    _server.startServer();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  void sendFile(String address, int port) {
    if (selectedFile.value != null) {
      _client.sendFile(selectedFile.value!.path, address, port);
    }
  }
}
