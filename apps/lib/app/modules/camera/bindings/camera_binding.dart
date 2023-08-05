import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/camera/controllers/camera_controller.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraController>(
      () => CameraController(),
    );
  }
}
