import 'package:get/get.dart';

import '../controllers/pre_game_rune_controller.dart';

class PreGameRuneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameRuneController>(
      () => PreGameRuneController(),
    );
  }
}
