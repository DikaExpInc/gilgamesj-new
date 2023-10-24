import 'package:get/get.dart';

import '../controllers/browser_search_controller.dart';

class BrowserSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrowserSearchController>(
      () => BrowserSearchController(),
    );
  }
}
