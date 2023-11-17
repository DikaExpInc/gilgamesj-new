import 'package:gilgamesj_tour/app/modules/mini_game_descibel_game/controllers/mini_game_descibel_game_controller.dart';
import 'package:get/get.dart';

class MiniGameDescibelGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameDescibelGameController>(
      () => MiniGameDescibelGameController(),
    );
  }
}
