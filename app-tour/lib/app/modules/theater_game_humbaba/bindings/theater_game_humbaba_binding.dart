import 'package:get/get.dart';

import '../controllers/theater_game_humbaba_controller.dart';

class TheaterGameHumbabaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameHumbabaController>(
      () => TheaterGameHumbabaController(),
    );
  }
}
