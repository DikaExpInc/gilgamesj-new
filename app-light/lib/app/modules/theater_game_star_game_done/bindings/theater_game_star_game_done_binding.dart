import 'package:get/get.dart';

import '../controllers/theater_game_star_game_done_controller.dart';

class TheaterGameStarGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameStarGameDoneController>(
      () => TheaterGameStarGameDoneController(),
    );
  }
}
