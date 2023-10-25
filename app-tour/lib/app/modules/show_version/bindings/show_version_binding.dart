import 'package:get/get.dart';

import '../controllers/show_version_controller.dart';

class ShowVersionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowVersionController>(
      () => ShowVersionController(),
    );
  }
}
