import 'package:get/get.dart';

import '../controllers/mini_game_music_theater_game_controller.dart';

class MiniGameMusicTheaterGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameMusicTheaterGameController>(
      () => MiniGameMusicTheaterGameController(),
    );
  }
}
