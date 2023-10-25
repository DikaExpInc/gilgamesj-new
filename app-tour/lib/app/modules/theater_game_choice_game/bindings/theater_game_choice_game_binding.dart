import 'package:get/get.dart';

import '../controllers/theater_game_choice_game_controller.dart';

class TheaterGameChoiceGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChoiceGameController>(
      () => TheaterGameChoiceGameController(),
    );
  }
}
