import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class CameraController extends GetxController {
  // final Completer<WebViewController> controllerCamera =
  //     Completer<WebViewController>();

  // JavascriptChannel toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         // ignore: deprecated_member_use
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text(message.message)));
  //       });
  // }

  @override
  void onInit() {
    super.onInit();
    requestCameraPermission();

    // print(status.isGranted);
    // if (status.isGranted) {
    // configureWebView();
    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://imagine-test.vercel.app/'));
    // } else {
    // Handle camera permission denied or permanently denied
    //   configureWebView();
    // }
    // });
  }

  Future<void> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      // Camera permission granted
    } else if (status.isDenied) {
      // Camera permission denied
    } else if (status.isPermanentlyDenied) {
      // Camera permission permanently denied, navigate to app settings
      openAppSettings();
    }
  }
}
