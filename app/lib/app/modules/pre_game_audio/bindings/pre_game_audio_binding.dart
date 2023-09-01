import 'package:get/get.dart';

import '../controllers/pre_game_audio_controller.dart';

class PreGameAudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameAudioController>(
      () => PreGameAudioController(),
    );
  }
}
