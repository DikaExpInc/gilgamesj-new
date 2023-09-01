import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_talking_video_controller.dart';

class PreGameTalkingVideoView extends GetView<PreGameTalkingVideoController> {
  late double mWidth;
  late double mHeight;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  final Map<String, dynamic> arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        child: Stack(
          children: [
            Container(
              width: mWidth,
              height: mHeight,
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(
                    url: Uri.https(AppConfig().ipaddr, "/gilgamesj")),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                ),
                onReceivedServerTrustAuthRequest:
                    (controller, challenge) async {
                  return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED);
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                androidOnPermissionRequest: (InAppWebViewController controller,
                    String origin, List<String> resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onConsoleMessage: (controllers, consoleMessage) {
                  if (controller.hasNavigated.value &&
                      consoleMessage.message == "unityTargetFound marker 4") {
                    // Menandai bahwa navigasi sudah terjadi
                    Future.delayed(Duration(seconds: 3), () {
                      // Setelah menunggu 3 detik, pindah ke halaman lain jika belum pernah navigasi
                      if (!controller.hasNavigated.value) {
                        Get.offAllNamed(Routes.PRE_GAME_AUDIO, arguments: {
                          "id": arguments['id']
                        }); // Ganti dengan nama rute halaman tujuan
                      }
                    });
                    controller.hasNavigated.value = false;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
