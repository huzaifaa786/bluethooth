import 'package:multicast_dns/multicast_dns.dart';

class MDNSDiscovery {
  final MDnsClient _mdnsClient = MDnsClient();

  Future<void> discoverServices(Function(String, int) onServiceFound) async {
    await _mdnsClient.start();

    await for (PtrResourceRecord ptr in _mdnsClient.lookup<PtrResourceRecord>(
        ResourceRecordQuery.serverPointer('_fileshare._tcp'))) {
      await for (SrvResourceRecord srv in _mdnsClient.lookup<SrvResourceRecord>(
          ResourceRecordQuery.service(ptr.domainName))) {
        onServiceFound(srv.target, srv.port);
      }
    }
  }

  Future<void> stopDiscovery() async {
    _mdnsClient.stop();
  }
}
