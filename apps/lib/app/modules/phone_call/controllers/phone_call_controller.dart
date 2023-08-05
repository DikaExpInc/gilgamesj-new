import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PhoneCallController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxString time = "00:00".obs;
  RxString idleTime = "00:00".obs;
  RxBool isIdleTimerRunning = false.obs;
  bool isRunning = false;
  AudioPlayer? audioPlayer;
  final AudioCache audioCache = AudioCache(
    prefix: 'assets/audios/',
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late RxString phoneNumber;
  final Map<String, dynamic> contactData = Get.arguments;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    phoneNumber = "0".obs;
    startIdleTimer();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updatePhoneNumber(String digit) {
    phoneNumber.value = phoneNumber.value + digit;
  }

  void deleteDigit() {
    if (phoneNumber.value.length > 1) {
      phoneNumber.value =
          phoneNumber.value.substring(0, phoneNumber.value.length - 1);
    } else {
      phoneNumber.value = "";
    }
  }

  void clearDigit() {
    phoneNumber.value = "";
  }

  void startTimer() {
    isRunning = true;
    update();

    Duration initialTime = Duration(minutes: 0, seconds: 0);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isRunning) {
        timer.cancel();
      } else {
        initialTime = initialTime + Duration(seconds: 1);
        int minutes = initialTime.inMinutes;
        int seconds = initialTime.inSeconds % 60;

        String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
        String secondsStr = seconds < 10 ? '0$seconds' : '$seconds';
        time.value = '$minutesStr:$secondsStr';
      }
    });
  }

  void stopTimer() {
    isRunning = false;
    update();
  }

  void resetTimer() {
    isRunning = false;
    time.value = "00:00";
    update();
  }

  Future<void> startIdleTimer() async {
    audioPlayer = await audioCache.play('cell_phone_ringing.mp3');
    if (isIdleTimerRunning.value) return;

    isIdleTimerRunning.value = true;
    update();

    Future.delayed(Duration(seconds: 5), () {
      isIdleTimerRunning.value = false;
      audioPlayer?.stop();
      idleTime.value = "00:00";
      startTimer();
      update();
    });

    Duration initialTime = Duration(seconds: 0);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isIdleTimerRunning.value) {
        timer.cancel();
      } else {
        initialTime = initialTime + Duration(seconds: 1);
        int minutes = initialTime.inMinutes;
        int seconds = initialTime.inSeconds % 60;

        String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
        String secondsStr = seconds < 10 ? '0$seconds' : '$seconds';
        idleTime.value = '$minutesStr:$secondsStr';
      }
    });
  }

  void resetIdleTimer() {
    isIdleTimerRunning.value = false;
    idleTime.value = "00:00";
    update();
    startIdleTimer();
  }
}
