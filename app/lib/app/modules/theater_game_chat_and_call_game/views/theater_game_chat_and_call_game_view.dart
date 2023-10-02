import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_chat_and_call_game_controller.dart';

class TheaterGameChatAndCallGameView
    extends GetView<TheaterGameChatAndCallGameController> {
  const TheaterGameChatAndCallGameView({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameChatAndCallGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
