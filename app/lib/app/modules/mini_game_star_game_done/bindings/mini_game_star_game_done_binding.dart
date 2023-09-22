import 'package:get/get.dart';

import '../controllers/mini_game_star_game_done_controller.dart';

class MiniGameStarGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameStarGameDoneController>(
      () => MiniGameStarGameDoneController(),
    );
  }
}
