import 'package:get/get.dart';

import '../controllers/theater_game_choice_game_winner_controller.dart';

class TheaterGameChoiceGameWinnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChoiceGameWinnerController>(
      () => TheaterGameChoiceGameWinnerController(),
    );
  }
}
