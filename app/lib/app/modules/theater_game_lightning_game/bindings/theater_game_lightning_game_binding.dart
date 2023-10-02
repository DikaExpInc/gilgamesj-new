import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_controller.dart';

class TheaterGameLightningGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameLightningGameController>(
      () => TheaterGameLightningGameController(),
    );
  }
}
