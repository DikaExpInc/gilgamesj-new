import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_star_timer_game_controller.dart';

// ignore: must_be_immutable
class MiniGameStarTimerGameView
    extends GetView<MiniGameStarTimerGameController> {
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/alarm_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                bottom: mHeight / 10,
                child: Container(
                  width: mWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => Text(
                          "Wake Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Centrion',
                            fontSize: 42,
                            color: controller.selectedAction.value == "Wake Up"
                                ? Colors.yellowAccent
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          width: 100, // Atur lebar container
                          height: 100, // Atur tinggi container
                          decoration: BoxDecoration(
                            shape: BoxShape
                                .circle, // Mengatur bentuknya menjadi lingkaran
                            color: Colors.white, // Warna lingkaran
                          ),
                        ),
                        onHorizontalDragUpdate: (details) {
                          if (details.delta.dx > 0) {
                            controller.selectedAction.value = "Snooze";
                          }
                          if (details.delta.dx < 0) {
                            controller.selectedAction.value = "Wake Up";
                          }
                        },
                      ),
                      Obx(
                        () => Text(
                          "Snooze",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Centrion',
                            fontSize: 42,
                            color: controller.selectedAction.value == "Snooze"
                                ? Colors.yellowAccent
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
