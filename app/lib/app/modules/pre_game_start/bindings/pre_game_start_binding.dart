import 'package:get/get.dart';

import '../controllers/pre_game_start_controller.dart';

class PreGameStartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameStartController>(
      () => PreGameStartController(),
    );
  }
}
