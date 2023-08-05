import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/camera/controllers/camera_controller.dart';
import 'package:gilgamesj/app/modules/camera/views/ar_view.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:pattern_lock/pattern_lock.dart';
// import 'package:flutter_webview_pro/webview_flutter.dart';

class CameraViewUrl extends GetView<CameraController> {
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
