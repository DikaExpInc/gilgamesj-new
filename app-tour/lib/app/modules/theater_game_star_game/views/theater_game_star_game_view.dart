import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_star_game_controller.dart';

class TheaterGameStarGameView extends GetView<TheaterGameStarGameController> {
  const TheaterGameStarGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameStarGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
