import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TheaterGameChoiceGameWinnerController extends GetxController {
  RxBool indexWinner = false.obs;
  @override
  void onInit() {
    if (GetStorage().read('game5-1') > GetStorage().read('game5-2')) {
      indexWinner.value = true;
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
