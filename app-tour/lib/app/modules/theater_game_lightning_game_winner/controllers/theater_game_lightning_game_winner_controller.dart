import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TheaterGameLightningGameWinnerController extends GetxController {
  RxBool indexWinner = false.obs;
  @override
  void onInit() {
    if (GetStorage().read('game2-1') > GetStorage().read('game2-2')) {
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
