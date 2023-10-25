import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_guess_controller.dart';

class PreGameGuessView extends GetView<PreGameGuessController> {
  const PreGameGuessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreGameGuessController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
