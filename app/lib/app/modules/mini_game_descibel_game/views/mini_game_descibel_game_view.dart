import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_descibel_game_controller.dart';

class MiniGameDescibelGameView extends GetView<MiniGameDescibelGameController> {
  const MiniGameDescibelGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/bg_decibel.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // child: Obx(
                              //   () => FAProgressBar(
                              //     backgroundColor: Colors.transparent,
                              //     borderRadius: BorderRadius.all(Radius.zero),
                              //     size: MediaQuery.of(context).size.width,
                              //     animatedDuration: Duration(milliseconds: 500),
                              //     maxValue: 90,
                              //     direction: Axis.vertical,
                              //     verticalDirection: VerticalDirection.up,
                              //     currentValue: controller
                              //             .latestReading.value?.meanDecibel ??
                              //         0,
                              //     displayText: ' dBA',
                              //     changeColorValue: 80,
                              //     changeProgressColor: Colors.red,
                              //     progressColor: Color(0xff86B8DF),
                              //   ),
                              // ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Obx(
                              () => AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                width: MediaQuery.sizeOf(context).width,
                                height: ((controller.latestReading.value
                                            ?.meanDecibel) ??
                                        0) *
                                    12,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/wave.gif"),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
