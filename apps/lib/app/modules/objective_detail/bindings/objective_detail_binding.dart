import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/objective_detail/controllers/objective_detail_controller.dart';

class ObjectiveDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObjectiveDetailController>(
      () => ObjectiveDetailController(),
    );
  }
}
