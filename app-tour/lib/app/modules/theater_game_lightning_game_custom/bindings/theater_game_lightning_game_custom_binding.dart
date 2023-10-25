import 'package:get/get.dart';

import '../controllers/theater_game_lightning_game_custom_controller.dart';

class TheaterGameLightningGameCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameLightningGameCustomController>(
      () => TheaterGameLightningGameCustomController(),
    );
  }
}
