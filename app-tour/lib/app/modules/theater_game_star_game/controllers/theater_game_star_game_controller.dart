import 'dart:async';

import 'package:gilgamesj_tour/app/modules/theater_game_star_game/views/screens/star_game_sky_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameStarGameController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isFinished = false.obs;
  final AudioCache audioCache =
      AudioCache(prefix: 'assets/audios/pregames/night_sounds/');
  AudioPlayer audioPlayer = AudioPlayer();
  late Timer audioTimer;
  Rx<String> audioFile = Rx<String>("");
  RxBool showButtons = true.obs;

  Rx<int> currentTimer = Rx<int>(0);
  RxInt selectedImageIndex = RxInt(-1);
  int tickCount = 0;

  RxString audio1 = RxString("");
  RxString audio2 = RxString("");
  RxString audio3 = RxString("");

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  Future<void> playAudio(String audioFileName) async {
    await audioPlayer.stop();
    audioPlayer = await audioCache.loop(audioFileName);
  }

  @override
  void onClose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    // print('terclose');
    super.onClose();
  }

  void startTapLoading() async {
    while (tapStatus.value) {
      await Future.delayed(Duration(milliseconds: 100));
      tapValue.value += 5;
      if (tapValue.value >= 100.0) {
        return nextStepAfterMessage();
      }
    }
  }

  void nextStepAfterMessage() {
    setWidget(StarGameSkyScreen());
  }

  void stopTapLoading() {
    tapStatus.value = false;
    tapValue.value = 0;
  }

  //TODO: Implement TheaterGameLightningGameController
  // Buat sebuah variabel yang akan menampung widget yang akan dipanggil
  late Widget selectedWidget;

  // Buat sebuah metode untuk mengatur widget yang akan dipanggil
  void setWidget(Widget widget) {
    selectedWidget = widget;
    update(); // Memaksa pembaruan tampilan
  }

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    // setWidget(StarGameMessageScreen());
    setWidget(StarGameSkyScreen());
    Vibration.vibrate(duration: 1000);

    super.onInit();
  }
}
