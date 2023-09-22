import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_lightning_game_controller.dart';

// ignore: must_be_immutable
class MiniGameLightningGameView
    extends GetView<MiniGameLightningGameController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameLightningGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
