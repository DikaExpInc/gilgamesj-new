import 'package:get/get.dart';

import '../controllers/mini_game_shake_game_controller.dart';

class MiniGameShakeGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameShakeGameController>(
      () => MiniGameShakeGameController(),
    );
  }
}
