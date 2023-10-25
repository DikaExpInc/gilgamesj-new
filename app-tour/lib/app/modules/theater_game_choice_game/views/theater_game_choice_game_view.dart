import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_choice_game_controller.dart';

class TheaterGameChoiceGameView extends GetView<TheaterGameChoiceGameController> {
  const TheaterGameChoiceGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameChoiceGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
