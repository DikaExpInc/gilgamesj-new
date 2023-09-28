import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mini_game_call_humbaba_game_controller.dart';

class MiniGameCallHumbabaGameView
    extends GetView<MiniGameCallHumbabaGameController> {
  const MiniGameCallHumbabaGameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MiniGameCallHumbabaGameController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
