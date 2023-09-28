import 'package:get/get.dart';

import '../controllers/mini_game_call_humbaba_game_controller.dart';

class MiniGameCallHumbabaGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameCallHumbabaGameController>(
      () => MiniGameCallHumbabaGameController(),
    );
  }
}
