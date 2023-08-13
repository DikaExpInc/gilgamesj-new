import 'package:get/get.dart';

import '../controllers/view_player_controller.dart';

class ViewPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewPlayerController>(
      () => ViewPlayerController(),
    );
  }
}
