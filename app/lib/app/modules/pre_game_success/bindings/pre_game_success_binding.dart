import 'package:get/get.dart';

import '../controllers/pre_game_success_controller.dart';

class PreGameSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameSuccessController>(
      () => PreGameSuccessController(),
    );
  }
}
