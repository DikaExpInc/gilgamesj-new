import 'package:get/get.dart';

import '../controllers/objective_detail_controller.dart';

class ObjectiveDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObjectiveDetailController>(
      () => ObjectiveDetailController(),
    );
  }
}
