import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_chat_and_call_game_controller.dart';

class MiniGameChatAndCallGameView
    extends GetView<MiniGameChatAndCallGameController> {
  const MiniGameChatAndCallGameView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameChatAndCallGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
