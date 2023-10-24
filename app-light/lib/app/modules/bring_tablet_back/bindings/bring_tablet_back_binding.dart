import 'package:get/get.dart';

import '../controllers/bring_tablet_back_controller.dart';

class BringTabletBackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BringTabletBackController>(
      () => BringTabletBackController(),
    );
  }
}
