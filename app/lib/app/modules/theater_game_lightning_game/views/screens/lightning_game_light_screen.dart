import 'package:app/app/modules/theater_game_lightning_game/controllers/theater_game_lightning_game_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class LightningGameLightScreen
    extends GetView<TheaterGameLightningGameController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.backgroundColors[controller.currentColorIndex.value],
        body: Center(),
      ),
    );
  }
}
