import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_descibel_game_controller.dart';

class PreGameDescibelGameView extends GetView<PreGameDescibelGameController> {
  const PreGameDescibelGameView({Key? key}) : super(key: key);
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/bg_decibel.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Obx(
                                () => FAProgressBar(
                                  backgroundColor: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.zero),
                                  size: MediaQuery.of(context).size.width,
                                  animatedDuration: Duration(milliseconds: 500),
                                  maxValue: 90,
                                  direction: Axis.vertical,
                                  verticalDirection: VerticalDirection.up,
                                  currentValue: controller
                                          .latestReading.value?.meanDecibel ??
                                      0,
                                  displayText: ' dBA',
                                  changeColorValue: 80,
                                  changeProgressColor: Colors.red,
                                  progressColor: Color(0xff86B8DF),
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
        floatingActionButton: GestureDetector(
          onLongPress: () {
            if (!controller.isRecording.value) {
              controller.start(); // Start recording when long press begins
            }
          },
          onLongPressEnd: (_) {
            if (controller.isRecording.value) {
              controller.stop(); // Stop recording when long press ends
              if (controller.latestReading.value!.maxDecibel >= 80) {
                controller.showItemDialog(
                    title: 'Waauw', description: 'Het is je gelukt !!');
                final AudioCache audioCache =
                    AudioCache(prefix: 'assets/audios/');
                audioCache.play('spirit_realms.mp3');
              } else {
                controller.latestReading.value = null;
              }
            }
          },
          child: FloatingActionButton(
            backgroundColor:
                controller.isRecording.value ? Colors.red : Colors.green,
            onPressed: () {}, // Empty onPressed to prevent default behavior
            child: controller.isRecording.value
                ? Icon(Icons.stop)
                : Icon(Icons.mic),
          ),
        ),
      ),
    );
  }
}
