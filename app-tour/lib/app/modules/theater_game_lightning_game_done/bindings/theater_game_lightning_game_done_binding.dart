import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_done_controller.dart';

class TheaterGameLightningGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameLightningGameDoneController>(
      () => TheaterGameLightningGameDoneController(),
    );
  }
}
