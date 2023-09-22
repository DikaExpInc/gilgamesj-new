import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_star_game_controller.dart';

class MiniGameStarGameView extends GetView<MiniGameStarGameController> {
  const MiniGameStarGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameStarGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
