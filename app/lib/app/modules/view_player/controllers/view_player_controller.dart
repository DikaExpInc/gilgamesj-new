import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/widgets/dialog/player_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ViewPlayerController extends GetxController {
  //TODO: Implement ViewPlayerController

  final box = GetStorage();

  Future<void> onNext() async {
    Get.toNamed(Routes.INTRODUCTION);
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
