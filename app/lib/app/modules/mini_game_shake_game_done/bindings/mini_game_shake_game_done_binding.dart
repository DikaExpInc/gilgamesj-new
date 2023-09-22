import 'package:get/get.dart';

import '../controllers/mini_game_shake_game_done_controller.dart';

class MiniGameShakeGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameShakeGameDoneController>(
      () => MiniGameShakeGameDoneController(),
    );
  }
}
