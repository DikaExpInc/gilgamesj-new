import 'package:get/get.dart';

import '../controllers/mini_game_choice_game_done_controller.dart';

class MiniGameChoiceGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameChoiceGameDoneController>(
      () => MiniGameChoiceGameDoneController(),
    );
  }
}
