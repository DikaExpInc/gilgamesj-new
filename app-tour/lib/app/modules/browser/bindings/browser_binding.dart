import 'package:get/get.dart';

import '../controllers/browser_controller.dart';

class BrowserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrowserController>(
      () => BrowserController(),
    );
  }
}
