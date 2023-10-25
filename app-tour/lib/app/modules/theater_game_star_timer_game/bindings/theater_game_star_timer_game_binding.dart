import 'package:get/get.dart';

import '../controllers/theater_game_star_timer_game_controller.dart';

class TheaterGameStarTimerGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameStarTimerGameController>(
      () => TheaterGameStarTimerGameController(),
    );
  }
}
