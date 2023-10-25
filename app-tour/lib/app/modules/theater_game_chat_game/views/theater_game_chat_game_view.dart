import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_chat_game_controller.dart';

class TheaterGameChatGameView extends GetView<TheaterGameChatGameController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameChatGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
