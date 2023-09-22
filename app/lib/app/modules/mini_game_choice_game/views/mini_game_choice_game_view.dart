import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_choice_game_controller.dart';

class MiniGameChoiceGameView extends GetView<MiniGameChoiceGameController> {
  const MiniGameChoiceGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameChoiceGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
