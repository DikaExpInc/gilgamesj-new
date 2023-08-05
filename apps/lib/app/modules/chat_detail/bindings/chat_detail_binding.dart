import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/chat_detail/controllers/chat_detail_controller.dart';

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailController>(
      () => ChatDetailController(),
    );
  }
}
