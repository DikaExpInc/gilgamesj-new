import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_custom_controller.dart';

class TheaterGameLightningGameCustomView
    extends GetView<TheaterGameLightningGameCustomController> {
  const TheaterGameLightningGameCustomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameLightningGameCustomController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
