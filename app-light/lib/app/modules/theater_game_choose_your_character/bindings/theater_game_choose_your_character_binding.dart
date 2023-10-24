import 'package:get/get.dart';

import '../controllers/theater_game_choose_your_character_controller.dart';

class TheaterGameChooseYourCharacterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChooseYourCharacterController>(
      () => TheaterGameChooseYourCharacterController(),
    );
  }
}
