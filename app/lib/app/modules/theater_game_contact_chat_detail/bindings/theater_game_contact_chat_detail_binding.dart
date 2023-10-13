import 'package:get/get.dart';

import '../controllers/theater_game_contact_chat_detail_controller.dart';

class TheaterGameContactChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheaterGameContactChatDetailController>(
      () => TheaterGameContactChatDetailController(),
    );
  }
}
