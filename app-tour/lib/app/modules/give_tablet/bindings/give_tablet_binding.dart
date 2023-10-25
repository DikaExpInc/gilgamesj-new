import 'package:get/get.dart';

import '../controllers/give_tablet_controller.dart';

class GiveTabletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiveTabletController>(
      () => GiveTabletController(),
    );
  }
}
