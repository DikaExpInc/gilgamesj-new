import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameChooseYourCharacterDoneController extends GetxController {
  Map<String, dynamic> arguments = Get.arguments;

  // onTap Loading
  @override
  void onInit() {
    super.onInit();
    Vibration.vibrate(duration: 1000);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
