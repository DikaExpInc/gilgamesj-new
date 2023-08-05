import 'dart:convert';

class FlutterOSCBundle {
  late String ip;
  late int port;
  Map oSCBundleList = {};
  int delay =
      0; // add timer to this class in the future for interval sending of packets
  String response = "";
  bool isClearBundle = false;

  FlutterOSCBundle(String ip, int port, bool clearBundle) {
    this.ip = ip;
    this.port = port;
    this.isClearBundle = clearBundle;
  }

  void emptyOSCBundle() {
    oSCBundleList = {};
  }

  dynamic convertJson(dynamic param) {
    const JsonEncoder encoder = JsonEncoder();
    final dynamic object = encoder.convert(param);
    return object;
  }
}
