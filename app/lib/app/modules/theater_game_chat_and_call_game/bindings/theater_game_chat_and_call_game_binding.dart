import 'package:get/get.dart';

import '../controllers/theater_game_chat_and_call_game_controller.dart';

class TheaterGameChatAndCallGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChatAndCallGameController>(
      () => TheaterGameChatAndCallGameController(),
    );
  }
}
