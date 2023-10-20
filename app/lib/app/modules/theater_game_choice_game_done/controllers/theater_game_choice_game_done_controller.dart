import 'dart:async';

import 'package:app/app/data/game5_model.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:app/app/services/game5_service.dart';
import 'package:get/get.dart';

class TheaterGameChoiceGameDoneController extends GetxController {
  RxBool isFinished = false.obs;
  Game5ListModel? game5;
  RxInt totalPlayer = 0.obs;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  final Stream game5Stream =
      Stream.periodic(const Duration(seconds: 2), (int count) {
    return count;
  });
  late StreamSubscription sub;

  @override
  void onInit() {
    super.onInit();
    print('harusnya jalan');
    loadPlayer();
    // membuat langganan
    sub = game5Stream.listen((event) {
      loadGame5();
      print('ini stream data');
    });
  }

  @override
  void onClose() {
    super.onClose();
    sub.cancel();
  }

  loadGame5() async {
    update();
    // showLoading();
    game5 = await Game5Api().loadGame5API();
    update();
    // stopLoading();
    if (game5?.statusCode == 200) {
    } else if (game5?.statusCode == 204) {
      print("Empty");
    } else if (game5?.statusCode == 404) {
      update();
    } else if (game5?.statusCode == 401) {
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
