import 'package:get/get.dart';

import '../controllers/theater_game_call_humbaba_game_done_controller.dart';

class TheaterGameCallHumbabaGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameCallHumbabaGameDoneController>(
      () => TheaterGameCallHumbabaGameDoneController(),
    );
  }
}
