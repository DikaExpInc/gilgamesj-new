import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/browser/controllers/browser_controller.dart';

class BrowserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrowserController>(
      () => BrowserController(),
    );
  }
}
