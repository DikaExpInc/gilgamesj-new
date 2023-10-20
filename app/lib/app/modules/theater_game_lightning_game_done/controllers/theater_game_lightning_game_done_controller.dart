import 'dart:async';

import 'package:app/app/data/game2_model.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:app/app/services/game2_service.dart';
import 'package:get/get.dart';

class TheaterGameLightningGameDoneController extends GetxController {
  RxBool isFinished = false.obs;
  Game2ListModel? game2;
  RxInt totalPlayer = 0.obs;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  final Stream game2Stream =
      Stream.periodic(const Duration(seconds: 2), (int count) {
    return count;
  });
  late StreamSubscription sub;

  @override
  void onInit() {
    super.onInit();
    loadPlayer();
    // membuat langganan
    sub = game2Stream.listen((event) {
      loadGame2();
      print('ini stream data');
    });
  }

  @override
  void onClose() {
    super.onClose();
    sub.cancel();
  }

  loadGame2() async {
    update();
    // showLoading();
    game2 = await Game2Api().loadGame2API();
    update();
    // stopLoading();
    if (game2?.statusCode == 200) {
    } else if (game2?.statusCode == 204) {
      print("Empty");
    } else if (game2?.statusCode == 404) {
      update();
    } else if (game2?.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  loadPlayer() async {
    update();
    totalPlayer.value = await AuthApi().getUsersAPI();
    update();
  }
}
