import 'package:get/get.dart';

import '../controllers/pre_game_music_theater_game_controller.dart';

class PreGameMusicTheaterGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreGameMusicTheaterGameController>(
      () => PreGameMusicTheaterGameController(),
    );
  }
}
