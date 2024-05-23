import 'dart:io';

class FileServer {
  Future<void> startServer() async {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, 4567);
    print(
        'Server running on IP: ${server.address.address} on port ${server.port}');

    await for (Socket client in server) {
      handleClient(client);
    }
  }

  void handleClient(Socket client) {
    print(
        'Connection from ${client.remoteAddress.address}:${client.remotePort}');

    client.listen((data) {
      // Handle received data (file bytes)
    }, onDone: () {
      print('Client left');
      client.close();
    });
  }
}
