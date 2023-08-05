import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/browser_search/controllers/browser_search_controller.dart';

class BrowserSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrowserSearchController>(
      () => BrowserSearchController(),
    );
  }
}
