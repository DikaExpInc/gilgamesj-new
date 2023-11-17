import 'package:gilgamesj_tour/app/data/user_model.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:gilgamesj_tour/app/services/auth_service.dart';
import 'package:gilgamesj_tour/app/widgets/toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateTeamController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  final box = GetStorage();
  UserModel? user;
  RxBool hasReconnect = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreatePegawai = false.obs;
  RxBool isButtonVisible = false.obs;
  RxInt totalPlayer = 1.obs;

  TextEditingController teamNameC = TextEditingController();

  @override
  onInit() {
    super.onInit();
    if (box.hasData("email") == true) {
      hasReconnect.value = true;
    } else {
      print("not logged in");
    }
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
  }

  void onSelectedTotalTeam(int totalTeam) {
    isButtonVisible.value = true;
    totalPlayer.value = totalTeam;
  }

  Future<void> addTeamName() async {
    // if (teamNameC.text.isNotEmpty) {
    isLoading.value = true;
    if (isLoadingCreatePegawai.isFalse) {
      await createTeamName();
      isLoading.value = false;
    }
    // } else {
    //   isLoading.value = false;
    //   CustomToast.errorToast('Error', 'you need to fill all form');
    // }
  }

  Widget get rotatingImage {
    return RotationTransition(
      turns: _controller,
      child: Image.asset('assets/images/isolation_mode.png'),
    );
  }

  createTeamName() async {
    update();
    user =
        await AuthApi().registerAPI(totalPlayer.toString(), box.read('role'));
    if (user!.statusCode == 201) {
      box.write("token", user!.accessToken);
      box.write("teamName", user!.username);
      update();
      Get.offAndToNamed(Routes.VIEW_PLAYER);
    } else if (user!.statusCode == 404) {
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

  void addPlayer() {
    if (totalPlayer <= 3) {
      totalPlayer++;
    }
  }

  void subsPlayer() {
    if (totalPlayer >= 2) {
      totalPlayer--;
    }
  }
}
