import 'package:get/get.dart';

import '../controllers/theater_game_reviving_controller.dart';

class TheaterGameRevivingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameRevivingController>(
      () => TheaterGameRevivingController(),
    );
  }
}
