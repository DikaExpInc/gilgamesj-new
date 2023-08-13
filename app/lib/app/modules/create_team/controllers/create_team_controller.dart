import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateTeamController extends GetxController {
  //TODO: Implement CreateTeamController

  final box = GetStorage();

  RxBool hasReconnect = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;
  RxBool isButtonVisible = false.obs;

  TextEditingController teamNameC = TextEditingController();

  @override
  onInit() {
    super.onInit();
    if (box.hasData("email") == true) {
      hasReconnect.value = true;
    } else {
      print("not logged in");
    }
  }

  Future<void> addTeamName() async {
    if (teamNameC.text.isNotEmpty) {
      isLoading.value = true;
      if (isLoadingCreatePegawai.isFalse) {
        await createTeamName();
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'you need to fill all form');
    }
  }

  createTeamName() async {
    Get.toNamed(Routes.CREATE_PLAYER);
  }

  reconnect() async {
    try {
      Get.toNamed(Routes.HOME);
    } catch (e) {
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }
}
