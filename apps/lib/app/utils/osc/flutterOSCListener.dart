import 'package:flutter/services.dart';
import 'dart:async';

class FlutterOSCListener {

  static const eventListener = const EventChannel('flutter.native/oscEvent');
  static const platform = const MethodChannel('flutter.native/osc');

    Stream oscStream = eventListener.receiveBroadcastStream();
    String _response = "";

      FlutterOSCListener(int incomingPort, String addressSelector){
        _setIncomingPort(incomingPort, addressSelector);
      }

      Future<void> _setIncomingPort(int incomingPort, String addressSelector) async {
        try {
          final String result = await platform.invokeMethod('setIncomingPort',<String, dynamic>{
            "incomingPort":incomingPort,
            "addressSelector": addressSelector,
          });
          _response = result;
          print(_response);
        } on PlatformException catch (e) {
          _response = "Failed to Invoke: '${e.message}'.";
          print(_response);
        }
      }




  }
