import 'package:get/get.dart';

import '../controllers/pre_game_shake_game_controller.dart';

class PreGameShakeGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameShakeGameController>(
      () => PreGameShakeGameController(),
    );
  }
}
