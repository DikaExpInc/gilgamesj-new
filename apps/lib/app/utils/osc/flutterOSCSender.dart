import 'dart:ffi';

import 'package:flutter/services.dart';
import 'dart:async';

class FlutterOSCSender {
  static const platform = const MethodChannel('flutter.native/osc');

  late String _ip;
  late int _port;
  String _response = "";
  int _delay = 0;

  FlutterOSCSender(String ip, int port) {
    this._ip = ip;
    this._port = port;
  }

  Future<void> sendOSCString(String address, List<String> arguments) async {
    try {
      final String result = await platform.invokeMethod(
          'sendOSCMessageString', <String, dynamic>{
        "IP": this._ip,
        "port": this._port,
        "address": address,
        "message": arguments
      });
      _response = result;
      print(_response);
    } on PlatformException catch (e) {
      _response = "Failed to Invoke: '${e.message}'.";
      print(_response);
    }
  }

  Future<void> sendOSCInt(String address, List<int> arguments) async {
    try {
      final String result = await platform.invokeMethod(
          'sendOSCMessageInteger', <String, dynamic>{
        "IP": this._ip,
        "port": this._port,
        "address": address,
        "message": arguments
      });
      _response = result;
      print(_response);
    } on PlatformException catch (e) {
      _response = "Failed to Invoke: '${e.message}'.";
      print(_response);
    }
  }

  Future<void> sendOSCFloat(String address, List<double> arguments) async {
    try {
      final String result = await platform.invokeMethod(
          'sendOSCMessageDouble', <String, dynamic>{
        "IP": this._ip,
        "port": this._port,
        "address": address,
        "message": arguments
      });
      _response = result;
      print(_response);
    } on PlatformException catch (e) {
      _response = "Failed to Invoke: '${e.message}'.";
      print(_response);
    }
  }

  Future<void> sendOSCBool(String address, List<bool> arguments) async {
    try {
      final String result = await platform.invokeMethod(
          'sendOSCMessageBoolean', <String, dynamic>{
        "IP": this._ip,
        "port": this._port,
        "address": address,
        "message": arguments
      });
      _response = result;
      print(_response);
    } on PlatformException catch (e) {
      _response = "Failed to Invoke: '${e.message}'.";
      print(_response);
    }
  }
}
