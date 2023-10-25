import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_winner_controller.dart';

class TheaterGameLightningGameWinnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameLightningGameWinnerController>(
      () => TheaterGameLightningGameWinnerController(),
    );
  }
}
