import 'package:flutter/services.dart';
import 'package:gilgamesj/app/utils/osc/flutterOSCBundle.dart';

class FlutterOSCBundleBool extends FlutterOSCBundle {
  static const _platform = const MethodChannel('flutter.native/osc');

  FlutterOSCBundleBool(String ip, int port, bool clearBundle)
      : super(ip, port, clearBundle);

  void addOSCMessageToBundle(String address, List<double> arguments) {
    oSCBundleList[address] = arguments;
  }

  Future<void> sendOSCBundleBool() async {
    try {
      final String result =
          await _platform.invokeMethod('bundleSenderBool', <String, dynamic>{
        "IP": ip,
        "port": port,
        "bundle": convertJson(oSCBundleList),
      });

      print("DART SIDE " + oSCBundleList.runtimeType.toString());
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
