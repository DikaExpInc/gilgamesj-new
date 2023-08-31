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
                              color: Colors.amber,
                              child: FAProgressBar(
                                backgroundColor: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.zero),
                                size: MediaQuery.of(context).size.width,
                                animatedDuration: Duration(milliseconds: 500),
                                maxValue: 90,
                                direction: Axis.vertical,
                                verticalDirection: VerticalDirection.up,
                                currentValue:
                                    controller.latestReading?.meanDecibel ?? 0,
                                displayText: ' dBA',
                                changeColorValue: 80,
                                changeProgressColor: Colors.red,
                                progressColor: Colors.green,
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
              if (controller.latestReading!.maxDecibel >= 80) {
                print("Berhasil Pindah halaman");
              } else {
                print("Berhasil");
                controller.latestReading = null;
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
