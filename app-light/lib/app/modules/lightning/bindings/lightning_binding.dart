import 'package:get/get.dart';

import '../controllers/lightning_controller.dart';

class LightningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LightningController>(
      () => LightningController(),
    );
  }
}
