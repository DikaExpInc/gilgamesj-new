import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MiniGameChatGameDoneController extends GetxController {
  //TODO: Implement MiniGameChatGameDoneController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    // Update player number
    int playedNumber = GetStorage().read('played_number') ?? 0;
    int totalPlayer = int.parse(GetStorage().read('totalPlayer'));
    if (playedNumber + 1 >= totalPlayer) {
      GetStorage().write('played_number', 0);
    } else {
      GetStorage().write('played_number', playedNumber + 1);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
