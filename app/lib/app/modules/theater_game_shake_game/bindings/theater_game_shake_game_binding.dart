import 'package:get/get.dart';

import '../controllers/theater_game_shake_game_controller.dart';

class TheaterGameShakeGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameShakeGameController>(
      () => TheaterGameShakeGameController(),
    );
  }
}
