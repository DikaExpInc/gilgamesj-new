import 'package:app/app/data/player_model.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:app/app/widgets/dialog/player_dialog.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ViewPlayerController extends GetxController {
  //TODO: Implement ViewPlayerController

  final box = GetStorage();
  RxBool isLoading = false.obs;
  PlayerListModel? playerListModel;
  var playerNameControllers = <TextEditingController>[].obs;

  Future<void> onNext() async {
    Get.toNamed(Routes.INTRODUCTION);
  }

  @override
  void onInit() {
    super.onInit();
    loadPlayers();
  }

  loadPlayers() async {
    update();
    showLoading();
    playerListModel = await AuthApi().loadAllPlayerAPI();
    update();
    stopLoading();
    if (playerListModel?.statusCode == 200) {
      // Inisialisasi data pemain dan TextEditingController
      for (var i = 0; i < playerListModel!.items!.length; i++) {
        playerNameControllers.add(TextEditingController());
        playerNameControllers[i].text = "SPELER ${i + 1}";
      }
    } else if (playerListModel!.statusCode == 204) {
      print("Empty");
    } else if (playerListModel!.statusCode == 404) {
      update();
    } else if (playerListModel!.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  void showPlayerDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: PlayerDialog(),
      ),
      barrierDismissible: false,
    );
  }
}
