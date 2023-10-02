import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_controller.dart';

// ignore: must_be_immutable
class TheaterGameLightningGameView
    extends GetView<TheaterGameLightningGameController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameLightningGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
