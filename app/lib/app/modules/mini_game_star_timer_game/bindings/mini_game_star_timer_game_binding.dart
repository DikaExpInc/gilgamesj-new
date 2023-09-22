import 'package:get/get.dart';

import '../controllers/mini_game_star_timer_game_controller.dart';

class MiniGameStarTimerGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameStarTimerGameController>(
      () => MiniGameStarTimerGameController(),
    );
  }
}
