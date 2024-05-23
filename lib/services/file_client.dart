import 'dart:io';

class FileClient {
  Future<void> sendFile(String filePath, String serverAddress, int port) async {
    final socket = await Socket.connect(serverAddress, port);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
   
    final file = File(filePath);
    socket.add(file.readAsBytesSync());
    await socket.flush();
    await socket.close();
  }
}
