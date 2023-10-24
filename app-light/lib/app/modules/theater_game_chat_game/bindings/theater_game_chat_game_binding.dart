import 'package:get/get.dart';

import '../controllers/theater_game_chat_game_controller.dart';

class TheaterGameChatGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameChatGameController>(
      () => TheaterGameChatGameController(),
    );
  }
}
