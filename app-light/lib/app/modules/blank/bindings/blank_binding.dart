import 'package:get/get.dart';

import '../controllers/blank_controller.dart';

class BlankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlankController>(
      () => BlankController(),
    );
  }
}
