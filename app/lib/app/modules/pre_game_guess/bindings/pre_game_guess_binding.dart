import 'package:get/get.dart';

import '../controllers/pre_game_guess_controller.dart';

class PreGameGuessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameGuessController>(
      () => PreGameGuessController(),
    );
  }
}
