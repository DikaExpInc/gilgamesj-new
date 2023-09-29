import 'package:get/get.dart';

import '../controllers/mini_game_call_humbaba_game_done_controller.dart';

class MiniGameCallHumbabaGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameCallHumbabaGameDoneController>(
      () => MiniGameCallHumbabaGameDoneController(),
    );
  }
}
