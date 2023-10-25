import 'package:get/get.dart';

import '../controllers/theater_game_chat_game_done_controller.dart';

class TheaterGameChatGameDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChatGameDoneController>(
      () => TheaterGameChatGameDoneController(),
    );
  }
}
