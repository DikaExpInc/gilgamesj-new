import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../data/chat_detail_model.dart';
import '../../../data/player_chat_model.dart';
import '../../../services/chat_detail_service.dart';
import '../../../widgets/loading.dart';

class ChatDetailController extends GetxController {
  //TODO: Implement ChatDetailController
  final Map<String, dynamic> chatData = Get.arguments;
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() {
    super.onInit();
    getAnswer();
  }

  initChat() async {
    update();
    PlayerChatModel playerChat =
        await ChatDetailApi().initChatAPI(chatData['id']);
    getChat();
    update();
    if (playerChat.statusCode == 200) {
    } else if (playerChat.statusCode == 204) {
      print("Empty");
    } else if (playerChat.statusCode == 404) {
      update();
    } else if (playerChat.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  replyChat() async {
    update();
    PlayerChatModel playerChat =
        await ChatDetailApi().replyChatAPI(chatData['id']);
    getChat();
    update();
    if (playerChat.statusCode == 200) {
    } else if (playerChat.statusCode == 204) {
      print("Empty");
    } else if (playerChat.statusCode == 404) {
      update();
    } else if (playerChat.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  getChat() async {
    update();
    PlayerChatListModel playerChat =
        await ChatDetailApi().getChatAPI(chatData['id']);
    pageAllController.updatePlayerChat(playerChat);
    update();
    if (playerChat.statusCode == 200) {
    } else if (playerChat.statusCode == 204) {
      print("Empty");
    } else if (playerChat.statusCode == 404) {
      update();
    } else if (playerChat.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  getAnswer() async {
    update();
    showLoading();
    ChatDetailListModel chatDetail =
        await ChatDetailApi().getAnswerAPI(chatData['id']);
    pageAllController.updateChatDetails(chatDetail);
    update();
    stopLoading();
    if (chatDetail.statusCode == 200) {
    } else if (chatDetail.statusCode == 204) {
      print("Empty");
    } else if (chatDetail.statusCode == 404) {
      update();
    } else if (chatDetail.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  answerChat(String id) async {
    update();
    PlayerChatModel playerChat =
        await ChatDetailApi().answerChatAPI(chatData['id'], id);
    getChat();
    update();
    if (playerChat.statusCode == 200) {
    } else if (playerChat.statusCode == 204) {
      print("Empty");
    } else if (playerChat.statusCode == 404) {
      update();
    } else if (playerChat.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}
