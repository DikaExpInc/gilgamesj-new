import 'package:get/get.dart';

import '../controllers/mini_game_lightning_game_controller.dart';

class MiniGameLightningGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameLightningGameController>(
      () => MiniGameLightningGameController(),
    );
  }
}
