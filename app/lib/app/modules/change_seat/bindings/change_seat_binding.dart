import 'package:get/get.dart';

import '../controllers/change_seat_controller.dart';

class ChangeSeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeSeatController>(
      () => ChangeSeatController(),
    );
  }
}
