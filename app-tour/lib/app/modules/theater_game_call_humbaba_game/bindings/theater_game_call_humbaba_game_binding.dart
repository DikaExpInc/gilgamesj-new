import 'package:get/get.dart';

import '../controllers/theater_game_call_humbaba_game_controller.dart';

class TheaterGameCallHumbabaGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameCallHumbabaGameController>(
      () => TheaterGameCallHumbabaGameController(),
    );
  }
}
