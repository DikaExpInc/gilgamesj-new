import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_humbaba_controller.dart';

class TheaterGameHumbabaView extends StatelessWidget {
  late double mWidth;
  late double mHeight;

  final TheaterGameHumbabaController controller =
      TheaterGameHumbabaController();

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: controller,
        dispose: (_) {
          controller.onClose();
        },
        builder: (context) {
          return Scaffold(
            body: Container(
              width: mWidth,
              height: mHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() => AnimatedSwitcher(
                        duration: Duration(seconds: 5),
                        child: controller.doneGame.value
                            ? controller.scrollBg.value
                                ? Container(
                                    width: mWidth,
                                    height: mHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/bg-night.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    key: ValueKey<int>(1),
                                  )
                                : Container(
                                    width: mWidth,
                                    height: mHeight,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/sunrise_bg.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    key: ValueKey<int>(2),
                                  )
                            : Container(
                                width: mWidth,
                                height: mHeight,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/star_sky_bg.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                key: ValueKey<int>(3),
                              ),
                      )),
                  Obx(
                    () => AnimatedPositioned(
                      duration: Duration(milliseconds: 2000),
                      width: mWidth / 10,
                      bottom: controller.showBeast.value ? 50 : -mWidth / 2,
                      left: mWidth / 3,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Image.asset(
                          'assets/images/beast-eye.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedPositioned(
                      duration: Duration(milliseconds: 2000),
                      curve: Curves.easeInOut,
                      width: mWidth * 1.5,
                      bottom: controller.scrollBg.value ? -150 : -1100,
                      right: controller.openTreeRight.value
                          ? -mWidth / 1.3
                          : -mWidth / 2,
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Image.asset(
                            'assets/images/tree.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        onHorizontalDragUpdate: (details) {
                          if (details.delta.dx > 0) {
                            controller.openTreeRight.value = true;
                          }
                          if (details.delta.dx < 0) {
                            controller.openTreeLeft.value = true;
                          }
                          if (!controller.showBeast.value) {
                            if (controller.openTreeLeft.value &&
                                controller.openTreeRight.value) {
                              controller.startAnimation();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedPositioned(
                      duration: Duration(milliseconds: 3000),
                      curve: Curves.easeInOut,
                      width: mWidth * 2,
                      bottom: controller.scrollBg.value ? -200 : -1500,
                      left: controller.openTreeLeft.value
                          ? -mWidth * 1.1
                          : -mWidth / 2,
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Image.asset(
                            'assets/images/tree.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        onHorizontalDragUpdate: (details) {
                          if (details.delta.dx > 0) {
                            controller.openTreeRight.value = true;
                          }
                          if (details.delta.dx < 0) {
                            controller.openTreeLeft.value = true;
                          }
                          if (!controller.showBeast.value) {
                            if (controller.openTreeLeft.value &&
                                controller.openTreeRight.value) {
                              controller.startAnimation();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.blackScreen.value
                        ? Positioned(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 2000),
                              width: mWidth,
                              height: mHeight,
                              color: Colors.black,
                              child: Image.asset(
                                'assets/images/beast-eye.png',
                                width: 200,
                                height: 200,
                              ),
                            ),
                          )
                        : Positioned(child: Container()),
                  ),
                ],
              ),
            ),
          );
        });
  }
}