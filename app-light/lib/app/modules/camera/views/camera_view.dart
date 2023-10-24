import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controllers/camera_controller.dart';

// ignore: must_be_immutable
class CameraView extends GetView<CameraController> {
  late double mWidth;
  late double mHeight;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

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
              height: mHeight / 1.2,
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(
                    url: Uri.https("192.168.1.8", "/ar-test-gilgamesj/demo1/")),
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
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: mWidth,
                height: mHeight / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0), BlendMode.srcOver),
                    image: AssetImage("assets/images/bg_bottom.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Input code in here",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: mWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0), BlendMode.srcOver),
                            image: AssetImage("assets/images/bg_input.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: TextField(
                          controller: controller.cameraCodeC,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            controller.isButtonVisible(value.isNotEmpty);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'INPUT CODE',
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Obx(() {
                          return controller.isButtonVisible.value
                              ? InkWell(
                                  onTap: () => {},
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/bg_btn.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                )
                              : SizedBox();
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
