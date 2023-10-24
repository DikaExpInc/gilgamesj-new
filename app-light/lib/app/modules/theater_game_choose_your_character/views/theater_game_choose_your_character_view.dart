import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_choose_your_character_controller.dart';

class TheaterGameChooseYourCharacterView
    extends GetView<TheaterGameChooseYourCharacterController> {
  const TheaterGameChooseYourCharacterView({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return GetBuilder<TheaterGameChooseYourCharacterController>(
      builder: (controller) {
        return controller.selectedWidget;
      },
    );
  }
}
