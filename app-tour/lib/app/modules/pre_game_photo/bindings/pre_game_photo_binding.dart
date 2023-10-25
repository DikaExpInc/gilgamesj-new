import 'package:get/get.dart';

import '../controllers/pre_game_photo_controller.dart';

class PreGamePhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGamePhotoController>(
      () => PreGamePhotoController(),
    );
  }
}
