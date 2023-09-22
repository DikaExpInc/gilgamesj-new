import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_chat_game_controller.dart';

class MiniGameChatGameView extends GetView<MiniGameChatGameController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameChatGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
