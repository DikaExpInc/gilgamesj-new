import 'package:get/get.dart';

import '../controllers/mini_game_chat_game_done_controller.dart';

class MiniGameChatGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameChatGameDoneController>(
      () => MiniGameChatGameDoneController(),
    );
  }
}
