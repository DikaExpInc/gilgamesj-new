import 'package:get/get.dart';

import '../controllers/mini_game_chat_game_controller.dart';

class MiniGameChatGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameChatGameController>(
      () => MiniGameChatGameController(),
    );
  }
}
