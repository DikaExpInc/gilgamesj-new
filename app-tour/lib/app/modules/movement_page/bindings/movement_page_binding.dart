import 'package:get/get.dart';

import '../controllers/movement_page_controller.dart';

class MovementPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovementPageController>(
      () => MovementPageController(),
    );
  }
}
