import 'package:get/get.dart';

import '../controllers/pre_game_talking_video_controller.dart';

class PreGameTalkingVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameTalkingVideoController>(
      () => PreGameTalkingVideoController(),
    );
  }
}
