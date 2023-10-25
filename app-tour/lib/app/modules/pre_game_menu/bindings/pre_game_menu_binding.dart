import 'package:get/get.dart';

import '../controllers/pre_game_menu_controller.dart';

class PreGameMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameMenuController>(
      () => PreGameMenuController(),
    );
  }
}
