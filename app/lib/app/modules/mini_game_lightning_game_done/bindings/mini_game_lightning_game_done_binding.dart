import 'package:get/get.dart';

import '../controllers/mini_game_lightning_game_done_controller.dart';

class MiniGameLightningGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameLightningGameDoneController>(
      () => MiniGameLightningGameDoneController(),
    );
  }
}
