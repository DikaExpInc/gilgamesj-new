import 'package:get/get.dart';

import '../controllers/theater_game_chat_and_call_game_done_controller.dart';

class TheaterGameChatAndCallGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChatAndCallGameDoneController>(
      () => TheaterGameChatAndCallGameDoneController(),
    );
  }
}
