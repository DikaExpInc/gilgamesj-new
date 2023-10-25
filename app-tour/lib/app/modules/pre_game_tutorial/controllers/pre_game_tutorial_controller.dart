import 'package:app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PreGameTutorialController extends GetxController {
  final RxList<bool> tappedList = RxList<bool>.of([false, false, false, false]);

  @override
  void onInit() {
    ever(tappedList, (_) {
      if (isAllTapped) {
        Get.toNamed(Routes.PRE_GAME_SPIRIT_REALM);
      }
    });
    super.onInit();
  }

  bool get isAllTapped =>
      tappedList[0] && tappedList[1] && tappedList[2] && tappedList[3];

  void toggleTap(int index, {bool isTapped = true}) {
    tappedList[index - 1] = isTapped;
  }
}
