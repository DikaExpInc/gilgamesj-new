import 'package:get/get.dart';

import '../controllers/pre_game_tutorial_controller.dart';

class PreGameTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameTutorialController>(
      () => PreGameTutorialController(),
    );
  }
}
