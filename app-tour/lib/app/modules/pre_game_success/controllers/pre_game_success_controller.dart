import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class PreGameSuccessController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isFinished = false.obs;

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
