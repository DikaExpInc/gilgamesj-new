import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../data/chat_detail_model.dart';
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
    loadChatDetail();
  }

  loadChatDetail() async {
    update();
    showLoading();
    ChatDetailListModel ChatDetail =
        await ChatDetailApi().loadChatDetailAPI(chatData['id']);
    pageAllController.updateChatDetails(ChatDetail);
    update();
    stopLoading();
    if (ChatDetail.statusCode == 200) {
    } else if (ChatDetail.statusCode == 204) {
      print("Empty");
    } else if (ChatDetail.statusCode == 404) {
      update();
    } else if (ChatDetail.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  
}
