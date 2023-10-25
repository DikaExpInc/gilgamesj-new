import 'package:get/get.dart';

import '../controllers/bonus_home_controller.dart';

class BonusHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusHomeController>(
      () => BonusHomeController(),
    );
  }
}
