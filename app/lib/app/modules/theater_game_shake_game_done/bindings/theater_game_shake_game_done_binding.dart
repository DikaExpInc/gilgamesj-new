import 'package:get/get.dart';

import '../controllers/theater_game_shake_game_done_controller.dart';

class TheaterGameShakeGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameShakeGameDoneController>(
      () => TheaterGameShakeGameDoneController(),
    );
  }
}
