import 'package:get/get.dart';

import '../controllers/dies_tablet_video_controller.dart';

class DiesTabletVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiesTabletVideoController>(
      () => DiesTabletVideoController(),
    );
  }
}
