import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreGameSpiritRealmController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerParticle;

  @override
  void onInit() {
    super.onInit();
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
