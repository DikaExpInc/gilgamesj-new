import 'package:get/get.dart';

import '../controllers/mini_game_music_game_controller.dart';

class MiniGameMusicGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameMusicGameController>(
      () => MiniGameMusicGameController(),
    );
  }
}
