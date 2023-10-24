import 'package:app/app/modules/theater_game_star_game_solving/controllers/theater_game_star_game_solving_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TheaterGameStarGameSolvingView
    extends GetView<TheaterGameStarGameSolvingController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
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
                                  image:
                                      AssetImage("assets/images/bg-night.png"),
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
                              image:
                                  AssetImage("assets/images/star_sky_bg.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          key: ValueKey<int>(3),
                        ),
                )),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  top: mHeight /
                      2.2, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("frog.mp3");
                            controller.increment(1);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(1)
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth / 1.2,
                  top: mHeight / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("gecko.mp3");
                            controller.increment(2);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(2)
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 10,
                            );
                          }),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("cricket-sound-113945.mp3");
                            controller.increment(3);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(3)
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth / 1.2,
                  top: mHeight /
                      20, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("night-ambience.mp3");
                            controller.increment(4);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(4)
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 2,
                            );
                          }),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("night-woods.mp3");
                            controller.increment(5);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(5)
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 2,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showButtons.value,
                child: Positioned(
                  width: mWidth,
                  top: mHeight /
                      30, // Sesuaikan dengan posisi horizontal yang diinginkan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: InkWell(
                          onTap: () {
                            controller.playAudio("campfire.mp3");
                            controller.increment(6);
                          },
                          child: Obx(() {
                            return Image.asset(
                              controller.isNumberPresentInString(6)
                                  ? 'assets/images/star.png'
                                  : 'assets/images/star1.png',
                              width: mWidth / 5,
                              height: mWidth / 5,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                left:
                    controller.openTreeLeft.value ? -mWidth * 1.1 : -mWidth / 2,
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
                          'assets/images/fang.gif',
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
  }
}
