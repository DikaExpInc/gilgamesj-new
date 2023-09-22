import 'package:app/app/modules/mini_game_lightning_game/controllers/mini_game_lightning_game_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_shake_game_controller.dart';

class MiniGameShakeGameView extends GetView<MiniGameShakeGameController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameShakeGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
