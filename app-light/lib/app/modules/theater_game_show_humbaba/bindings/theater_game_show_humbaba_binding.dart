import 'package:get/get.dart';

import '../controllers/theater_game_show_humbaba_controller.dart';

class TheaterGameShowHumbabaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameShowHumbabaController>(
      () => TheaterGameShowHumbabaController(),
    );
  }
}
