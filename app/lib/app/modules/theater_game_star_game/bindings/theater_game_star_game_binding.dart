import 'package:get/get.dart';

import '../controllers/theater_game_star_game_controller.dart';

class TheaterGameStarGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameStarGameController>(
      () => TheaterGameStarGameController(),
    );
  }
}
