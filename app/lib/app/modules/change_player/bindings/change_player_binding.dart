import 'package:get/get.dart';

import '../controllers/change_player_controller.dart';

class ChangePlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePlayerController>(
      () => ChangePlayerController(),
    );
  }
}
