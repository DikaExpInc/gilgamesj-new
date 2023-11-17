import 'package:gilgamesj_tour/app/modules/bonus_camera/controllers/bonus_camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class BonusCameraView extends GetView<BonusCameraController> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest:
              URLRequest(url: Uri.parse("https://imagine-test.vercel.app")),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      ),
    );
  }
}
