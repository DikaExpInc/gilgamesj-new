import 'dart:async';

import 'package:app/app/modules/theater_game_shake_game/views/screens/music_shake_game_main_screen.dart';
import 'package:app/app/modules/theater_game_shake_game/views/screens/music_shake_game_message_screen.dart';
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

  late Timer audioTimer;
  Rx<String> audioFile = Rx<String>("");
  int tickCount = 0;
  Rx<int> currentTimer = Rx<int>(0);

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
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    setWidget(MusicShakeGameMessageScreen());
    Vibration.vibrate(duration: 1000);

    shakeDetector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1.5,
        onPhoneShake: () async {
          if (!isShaking.value) {
            isShaking.value = true;
            audioFile.value = 'song-game-1-shake-phone.wav';
            // Future.delayed(Duration(milliseconds: 100), () async {
            //   isShaking.value = false;
            // });
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
    const timerDuration = Duration(seconds: 1);
    audioTimer = Timer.periodic(timerDuration, (timer) async {
      // Tambah tickCount dan atur ulang ke 0 jika mencapai 13
      tickCount = (tickCount + 1) % 14;

      // Kirim nilai ke Rx variable
      currentTimer.value = tickCount;
      if (currentTimer.value == 0 &&
          audioFile.value == "song-game-1-shake-phone.wav") {
        audioPlayer = await audioCache.loop(audioFile.value);
        audioFile.value = "";
      }
    });

    super.onInit();
  }
}
