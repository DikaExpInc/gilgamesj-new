import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_shake_game_controller.dart';
import 'package:video_player/video_player.dart';

class PreGameShakeGameView extends GetView<PreGameShakeGameController> {
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
                      child: Transform.rotate(
                        angle: 22 * 3.14 / -180,
                        child: InkWell(
                          onTap: () {
                            controller.increment(1);
                          },
                          child: Image.asset(
                            'assets/images/btn-shake-1.png',
                            width: mWidth / 2,
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 7,
                      left: 80,
                    ),
                    Positioned(
                      child: Transform.rotate(
                        angle: 35 * 3.14 / 180,
                        child: InkWell(
                          onTap: () {
                            controller.increment(2);
                          },
                          child: Image.asset(
                            'assets/images/btn-shake-2.png',
                            width: mWidth / 2,
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 2.7,
                      right: 70,
                    ),
                    Positioned(
                      child: Transform.rotate(
                        angle: 0 * 3.14 / 180,
                        child: InkWell(
                          onTap: () {
                            controller.increment(3);
                          },
                          child: Image.asset(
                            'assets/images/btn-shake-3.png',
                            width: mWidth / 2,
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 1.75,
                      left: 70,
                    ),
                    Positioned(
                      child: Transform.rotate(
                        angle: -20 * 3.14 / 180,
                        child: InkWell(
                          onTap: () {
                            controller.increment(4);
                          },
                          child: Image.asset(
                            'assets/images/btn-shake-4.png',
                            width: mWidth / 2,
                          ),
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 1.3,
                      right: 90,
                    ),
                  ],
                )
              : VideoPlayer(controller.videocontroller!),
        ),
      ),
    );
  }
}
