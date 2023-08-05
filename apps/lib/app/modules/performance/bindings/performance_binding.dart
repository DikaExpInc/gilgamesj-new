import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/performance/controllers/performance_controller.dart';

class PerformanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerformanceController>(
      () => PerformanceController(),
    );
  }
}
