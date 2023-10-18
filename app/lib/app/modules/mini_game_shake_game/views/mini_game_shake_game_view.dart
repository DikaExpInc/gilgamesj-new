import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/mini_game_shake_game_controller.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class MiniGameShakeGameView extends GetView<MiniGameShakeGameController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Obx(
          () => controller.isDone.value
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg-shake.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          controller.increment(1);
                        },
                        child: Obx(
                          () => AnimatedSwitcher(
                            duration: Duration(milliseconds: 100),
                            child: controller.isNumberPresentInString(1)
                                ? Image.asset(
                                    'assets/images/btn-shake-1-active.png',
                                    key: ValueKey<int>(1),
                                    width: mWidth / 1.7,
                                  )
                                : Image.asset(
                                    "assets/images/btn-shake-1.png",
                                    key: ValueKey<int>(2),
                                    width: mWidth / 1.7,
                                  ),
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 7,
                      left: 80,
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          controller.increment(2);
                        },
                        child: Obx(
                          () => AnimatedSwitcher(
                            duration: Duration(milliseconds: 100),
                            child: controller.isNumberPresentInString(2)
                                ? Image.asset(
                                    'assets/images/btn-shake-2-active.png',
                                    key: ValueKey<int>(1),
                                    width: mWidth / 1.7,
                                  )
                                : Image.asset(
                                    "assets/images/btn-shake-2.png",
                                    key: ValueKey<int>(2),
                                    width: mWidth / 1.7,
                                  ),
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 2.7,
                      right: 70,
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          controller.increment(3);
                        },
                        child: Obx(
                          () => AnimatedSwitcher(
                            duration: Duration(milliseconds: 100),
                            child: controller.isNumberPresentInString(3)
                                ? Image.asset(
                                    'assets/images/btn-shake-3-active.png',
                                    key: ValueKey<int>(1),
                                    width: mWidth / 1.7,
                                  )
                                : Image.asset(
                                    "assets/images/btn-shake-3.png",
                                    key: ValueKey<int>(2),
                                    width: mWidth / 1.7,
                                  ),
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 1.75,
                      left: 70,
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: () {
                          controller.increment(4);
                        },
                        child: Obx(
                          () => AnimatedSwitcher(
                            duration: Duration(milliseconds: 100),
                            child: controller.isNumberPresentInString(4)
                                ? Image.asset(
                                    'assets/images/btn-shake-4-active.png',
                                    key: ValueKey<int>(1),
                                    width: mWidth / 1.7,
                                  )
                                : Image.asset(
                                    "assets/images/btn-shake-4.png",
                                    key: ValueKey<int>(2),
                                    width: mWidth / 1.7,
                                  ),
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 1.3,
                      right: 90,
                    ),
                  ],
                )
              : Stack(
                  children: [
                    VideoPlayer(
                      controller.videocontroller!,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
