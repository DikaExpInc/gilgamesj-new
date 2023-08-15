import 'package:app/app/data/player_model.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:app/app/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreatePlayerController extends GetxController {
  //TODO: Implement CreateTeamController

  final box = GetStorage();
  PlayerModel? player;

  RxBool hasReconnect = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;

  TextEditingController totalPlayerC = TextEditingController();
  RxBool isButtonVisible = false.obs;

  @override
  onInit() {
    super.onInit();
    if (box.hasData("email") == true) {
      hasReconnect.value = true;
    } else {
      print("not logged in");
    }
  }

  Future<void> addPlayer() async {
    if (totalPlayerC.text.isNotEmpty) {
      final int totalPlayer = int.tryParse(totalPlayerC.text) ?? 0;

      if (totalPlayer >= 2 && totalPlayer <= 4) {
        isLoading.value = true;
        if (isLoadingCreatePegawai.isFalse) {
          await createTotalPlayer();
          isLoading.value = false;
        }
      } else {
        CustomToast.errorToast(
            'Error', 'Total players must be between 2 and 4');
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'you need to fill all form');
    }
  }

  createTotalPlayer() async {
    update();
    player = await AuthApi().addplayerAPI(totalPlayerC.text);
    if (player!.statusCode == 201) {
      box.write("totalPlayer", totalPlayerC.text);
      Get.toNamed(Routes.VIEW_PLAYER);
    } else if (player!.statusCode == 404) {
      update();
    }
  }

  reconnect() async {
    try {
      Get.toNamed(Routes.HOME);
    } catch (e) {
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }
}
