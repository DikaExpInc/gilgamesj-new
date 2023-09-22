import 'package:get/get.dart';

import '../controllers/mini_game_choice_game_controller.dart';

class MiniGameChoiceGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameChoiceGameController>(
      () => MiniGameChoiceGameController(),
    );
  }
}
