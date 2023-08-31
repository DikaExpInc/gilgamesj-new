import 'package:get/get.dart';

import '../controllers/pre_game_music_game_controller.dart';

class PreGameMusicGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameMusicGameController>(
      () => PreGameMusicGameController(),
    );
  }
}
