import 'package:get/get.dart';

import '../controllers/theater_game_star_game_solving_controller.dart';

class TheaterGameStarGameSolvingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameStarGameSolvingController>(
      () => TheaterGameStarGameSolvingController(),
    );
  }
}
