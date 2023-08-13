import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  //TODO: Implement ChatDetailController
  RxBool isBottomSheetVisible = false.obs;
  final Map<String, dynamic> chatData = Get.arguments;

  void toggleBottomSheetVisibility() {
    isBottomSheetVisible.value = !isBottomSheetVisible.value;
  }
}
