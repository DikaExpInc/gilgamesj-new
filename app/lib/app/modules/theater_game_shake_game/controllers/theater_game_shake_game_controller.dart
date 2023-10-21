import 'dart:async';

import 'package:app/app/modules/theater_game_shake_game/views/screens/music_shake_game_main_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

class TheaterGameShakeGameController extends GetxController
    with GetTickerProviderStateMixin {
  ShakeDetector? shakeDetector;

  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;

  Rx<String> audioFile = Rx<String>("");

  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer audioPlayer = AudioPlayer();

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    shakeDetector!.stopListening();
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
    setWidget(MusicShakeGameMainScreen());
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
  Future<void> onInit() async {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    // setWidget(MusicShakeGameMessageScreen());
    setWidget(MusicShakeGameMainScreen());
    Vibration.vibrate(duration: 1000);

    shakeDetector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1.0,
        onPhoneShake: () async {
          if (!isShaking.value) {
            isShaking.value = true;
            audioPlayer.setVolume(1);
            Future.delayed(Duration(milliseconds: 4000), () async {
              audioPlayer.setVolume(0.0);
              isShaking.value = false;
            });
          }
        });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    // Atur timer dengan interval 13 detik
    audioFile.value = '3. stadsgeluiden (schudden schudden).wav';
    audioPlayer = await audioCache.loop(audioFile.value);
    audioPlayer.setVolume(0.0);

    super.onInit();
  }
}
