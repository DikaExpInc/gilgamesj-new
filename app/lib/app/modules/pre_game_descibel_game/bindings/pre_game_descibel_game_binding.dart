import 'package:get/get.dart';

import '../controllers/pre_game_descibel_game_controller.dart';

class PreGameDescibelGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameDescibelGameController>(
      () => PreGameDescibelGameController(),
    );
  }
}
