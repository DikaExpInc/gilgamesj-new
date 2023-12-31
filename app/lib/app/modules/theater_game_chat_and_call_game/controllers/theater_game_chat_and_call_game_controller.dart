import 'dart:async';

import 'package:app/app/modules/theater_game_chat_and_call_game/views/screens/chat_and_call_game_call_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameChatAndCallGameController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;

  RxString time = "00:00".obs;
  RxString idleTime = "00:00".obs;
  RxBool isIdleTimerRunning = false.obs;
  bool isRunning = false;
  late AudioPlayer audioPlayer;
  final AudioCache audioCache = AudioCache(
    prefix: 'assets/audios/',
  );
  RxBool isCall = false.obs;
  RxBool isGlitch = false.obs;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
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
    setWidget(ChatAndCallGameCallScreen());
    startIdleTimer();
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
    // setWidget(ChatandCallGameMessageScreen());
    setWidget(ChatAndCallGameCallScreen());
    startIdleTimer();
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

  Future<void> startIdleTimer() async {
    audioPlayer = await audioCache.loop('cell_phone_ringing.mp3');
    update();
  }

  Future<void> callPhone() async {
    isCall.value = true;
    audioPlayer?.stop();
    // audioPlayer = await audioCache.play('phonecall-ishtar.mp3');
    // audioPlayer?.onPlayerCompletion.listen((event) async {
    //   audioPlayer = await audioCache.play('call_phone_reject.mp3');
    //   audioPlayer?.onPlayerCompletion.listen((event) async {
    //     Get.offNamed(Routes.BLANK);
    //   });
    // });
    idleTime.value = "00:00";
    startTimer();
    update();

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

  void dissCallPhone() {
    isGlitch.value = true;
    Future.delayed(Duration(seconds: 1)).then(
      (value) => isGlitch.value = false,
    );
  }
}
