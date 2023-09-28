import 'package:get/get.dart';

import '../controllers/mini_game_chat_and_call_game_controller.dart';

class MiniGameChatAndCallGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MiniGameChatAndCallGameController>(
      () => MiniGameChatAndCallGameController(),
    );
  }
}
