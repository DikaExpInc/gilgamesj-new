import 'package:get/get.dart';

import '../controllers/clap_controller.dart';

class ClapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClapController>(
      () => ClapController(),
    );
  }
}
