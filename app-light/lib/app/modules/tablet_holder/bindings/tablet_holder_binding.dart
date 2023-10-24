import 'package:get/get.dart';

import '../controllers/tablet_holder_controller.dart';

class TabletHolderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabletHolderController>(
      () => TabletHolderController(),
    );
  }
}
