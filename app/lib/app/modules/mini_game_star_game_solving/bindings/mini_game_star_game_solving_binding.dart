import 'package:get/get.dart';

import '../controllers/mini_game_star_game_solving_controller.dart';

class MiniGameStarGameSolvingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameStarGameSolvingController>(
      () => MiniGameStarGameSolvingController(),
    );
  }
}
