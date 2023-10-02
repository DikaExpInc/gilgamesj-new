import 'package:app/app/modules/theater_game_chat_and_call_game/controllers/theater_game_chat_and_call_game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountdownTimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TheaterGameChatAndCallGameController countdownController =
        Get.put(TheaterGameChatAndCallGameController());

    return Obx(() {
      return countdownController.isIdleTimerRunning.value
          ? Text(
              "calling",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            )
          : Text(
              countdownController.time.value,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            );
    });
  }
}
