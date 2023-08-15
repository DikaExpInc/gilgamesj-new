import 'dart:async';

import 'package:app/app/data/task_model.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/widgets/dialog/bonus_dialog.dart';
import 'package:app/app/widgets/dialog/bonus_skip_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PageAllController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxInt lengthNow = 0.obs;
  TaskListModel? tasks;

  // timer
  RxString countdown = '00:00'.obs;
  RxInt countdownInMinutes = 0.obs;
  DateTime? startTime;
  Duration? duration;
  Duration? remainingTime;

  @override
  void onInit() {
    super.onInit();
  }

  void showBonusDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: BonusDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void showSkipBonusDialog() {
    Get.back();
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          // Cegah dialog ditutup dengan tombol "back"
          return false;
        },
        child: BonusSkipDialog(),
      ),
      barrierDismissible: false,
    );
  }

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        Get.offAllNamed(Routes.START);
        break;
      case 2:
        Get.offAllNamed(Routes.BLANK);
        break;
      case 3:
        Get.offAllNamed(Routes.CLAP);
        break;
      case 4:
        Get.offAllNamed(Routes.PERFORMANCE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }

  void startCountdown(Duration remainingTime) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        remainingTime -= Duration(seconds: 1);
        String formattedCountdown =
            '${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}';
        countdown.value = formattedCountdown;
        countdownInMinutes.value = remainingTime.inMinutes;
      } else {
        Get.offNamed(Routes.PERFORMANCE);
        timer.cancel(); // Stop the timer when countdown reaches 0 or negative
      }
    });
  }
}
