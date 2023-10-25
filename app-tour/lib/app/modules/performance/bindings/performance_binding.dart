import 'package:get/get.dart';

import '../controllers/performance_controller.dart';

class PerformanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerformanceController>(
      () => PerformanceController(),
    );
  }
}
