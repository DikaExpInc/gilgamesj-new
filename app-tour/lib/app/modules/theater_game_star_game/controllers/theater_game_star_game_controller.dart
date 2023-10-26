import 'dart:async';

import 'package:app/app/modules/theater_game_star_game/views/screens/star_game_message_screen.dart';
import 'package:app/app/modules/theater_game_star_game/views/screens/star_game_sky_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameStarGameController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerParticle;
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

  // Method untuk memainkan audio
  void playAudio(String audioFileName) {
    audioPlayer.stop();
    Future.delayed(Duration(seconds: 1), () async {
      audioPlayer = await audioCache.loop(audioFileName);
    });
  }

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    audioPlayer.stop();
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

  Widget get rotatingImage {
    return RotationTransition(
      turns: _controller,
      child: Image.asset('assets/images/center_of_god.png'),
    );
  }

  Widget get rotatingParticle {
    return RotationTransition(
      turns: _controllerParticle,
      child: Image.asset('assets/images/particle.png'),
    );
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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    super.onInit();
  }
}
