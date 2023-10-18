import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/scan_ar_controller.dart';

class ScanArView extends GetView<ScanArController> {
  late double mWidth;
  late double mHeight;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  final Map<String, dynamic> arguments = Get.arguments;
  bool hasNavigatedValue = false;

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
                    url: Uri.https(
                        AppConfig().ipaddr, "${controller.arguments['link']}")),
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
                  if (!controller.hasNavigated.value &&
                      consoleMessage.message == "unityTargetFound marker 4") {
                    Future.delayed(const Duration(seconds: 15), () {
                      if (!controller.hasNavigated.value) {
                        int playedNumber =
                            GetStorage().read('played_number') ?? 0;

                        int totalPlayer =
                            int.parse(GetStorage().read('totalPlayer'));

                        if (playedNumber + 1 >= totalPlayer) {
                          GetStorage().write('played_number', 0);
                        } else {
                          GetStorage().write('played_number', playedNumber + 1);
                        }

                        Get.offAllNamed(Routes.PRE_GAME_AUDIO, arguments: {
                          "id": arguments['id']
                        }); // Ganti dengan nama rute halaman tujuan
                      }
                      controller.hasNavigated.value = true;
                    });
                  }
                },
              ),
            ),
            Obx(
              () => controller.hasNavigated.value
                  ? Positioned(
                      bottom: 0,
                      child: Container(
                        width: mWidth,
                        height: mHeight / 6,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0), BlendMode.srcOver),
                            image:
                                const AssetImage("assets/images/bg_bottom.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          child: Center(
                            child: InkWell(
                              onTap: () => {
                                Get.offAllNamed(
                                  Routes.PRE_GAME_AUDIO,
                                  arguments: {"id": arguments['id']},
                                ),
                                GetStorage().write('played_number',
                                    GetStorage().read('played_number') + 1)
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/bg_btn.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "DOORGAAN",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
