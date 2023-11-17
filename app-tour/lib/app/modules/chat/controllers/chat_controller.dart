import 'package:gilgamesj_tour/app/data/chat_model.dart';
import 'package:gilgamesj_tour/app/services/chat_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../widgets/loading.dart';

class ChatController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() {
    super.onInit();
    loadChat();
  }

  loadChat() async {
    update();
    showLoading();
    ChatListModel chat = await ChatApi().loadChatAPI();
    pageAllController.updateChat(chat);
    update();
    stopLoading();
    if (chat.statusCode == 200) {
    } else if (chat.statusCode == 204) {
      print("Empty");
    } else if (chat.statusCode == 404) {
      update();
    } else if (chat.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
