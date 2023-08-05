import 'package:flutter/services.dart';
import 'package:gilgamesj/app/utils/osc/flutterOSCBundle.dart';

class FlutterOSCBundleFloat extends FlutterOSCBundle {
  static const _platform = const MethodChannel('flutter.native/osc');

  FlutterOSCBundleFloat(String ip, int port, bool clearBundle)
      : super(ip, port, clearBundle);

  void addOSCMessageToBundle(String address, List<double> arguments) {
    oSCBundleList[address] = arguments;
  }

  Future<void> sendOSCBundleFloat() async {
    try {
      final String result =
          await _platform.invokeMethod('bundleSenderFloat', <String, dynamic>{
        "IP": ip,
        "port": port,
        "bundle": convertJson(oSCBundleList),
      });

      response = result;
      print(response);

      if (isClearBundle) {
        oSCBundleList = {};
      }
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      print(response);
    }
  }
}
