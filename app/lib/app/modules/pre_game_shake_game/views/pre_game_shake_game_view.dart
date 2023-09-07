import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_shake_game_controller.dart';
import 'package:video_player/video_player.dart';

class PreGameShakeGameView extends GetView<PreGameShakeGameController> {
  const PreGameShakeGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                        child: Image.asset(
                          'assets/images/btn-shake-1.png',
                          width: 200,
                        ),
                      ),
                      top: MediaQuery.sizeOf(context).height / 7,
                      left: 80,
                    ),
                  ],
                )
              : VideoPlayer(controller.videocontroller!),
        ),
      ),
    );
  }
}
