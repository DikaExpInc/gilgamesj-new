import 'package:app/app/modules/theater_game_lightning_game/controllers/theater_game_lightning_game_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_shake_game_controller.dart';

class TheaterGameShakeGameView extends GetView<TheaterGameShakeGameController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameShakeGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
