import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_call_humbaba_game_controller.dart';

class TheaterGameCallHumbabaGameView
    extends GetView<TheaterGameCallHumbabaGameController> {
  const TheaterGameCallHumbabaGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameCallHumbabaGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
