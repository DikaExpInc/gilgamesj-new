import 'package:get/get.dart';

import '../controllers/theater_game_choice_game_done_controller.dart';

class TheaterGameChoiceGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChoiceGameDoneController>(
      () => TheaterGameChoiceGameDoneController(),
    );
  }
}
