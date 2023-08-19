import 'package:get/get.dart';

import '../controllers/go_theater_controller.dart';

class GoTheaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoTheaterController>(
      () => GoTheaterController(),
    );
  }
}
