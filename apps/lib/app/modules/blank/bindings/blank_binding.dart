import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/blank/controllers/blank_controller.dart';

class BlankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlankController>(
      () => BlankController(),
    );
  }
}
