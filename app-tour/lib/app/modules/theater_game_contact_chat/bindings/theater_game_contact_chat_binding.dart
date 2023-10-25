import 'package:get/get.dart';

import '../controllers/theater_game_contact_chat_controller.dart';

class TheaterGameContactChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameContactChatController>(
      () => TheaterGameContactChatController(),
    );
  }
}
