import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/bonus_camera/controllers/bonus_camera_controller.dart';

class BonusCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusCameraController>(
      () => BonusCameraController(),
    );
  }
}
