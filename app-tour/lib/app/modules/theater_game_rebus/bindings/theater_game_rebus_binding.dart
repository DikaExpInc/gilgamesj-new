import 'package:get/get.dart';

import '../controllers/theater_game_rebus_controller.dart';

class TheaterGameRebusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameRebusController>(
      () => TheaterGameRebusController(),
    );
  }
}
