import 'package:get/get.dart';

import '../controllers/mini_game_star_game_controller.dart';

class MiniGameStarGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameStarGameController>(
      () => MiniGameStarGameController(),
    );
  }
}
