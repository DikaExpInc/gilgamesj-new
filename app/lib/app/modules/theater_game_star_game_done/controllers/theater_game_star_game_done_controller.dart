import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';

class TheaterGameStarGameDoneController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;

  @override
  void onInit() {
    super.onInit();

    Vibration.vibrate(duration: 1000);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
    audioCache.play('spirit_realms.mp3');

    // Update player number
    int playedNumber = GetStorage().read('played_number') ?? 0;
    int totalPlayer = int.parse(GetStorage().read('totalPlayer'));
    if (playedNumber + 1 >= totalPlayer) {
      GetStorage().write('played_number', 0);
    } else {
      GetStorage().write('played_number', playedNumber + 1);
    }
  }

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    super.onClose();
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
}
