import 'package:app/app/modules/mini_game_shake_game/views/screens/music_shake_game_message_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

class MiniGameShakeGameController extends GetxController
    with GetTickerProviderStateMixin {
  ShakeDetector? shakeDetector;

  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;

  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    shakeDetector!.stopListening();
    audioPlayer.stop();
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

  //TODO: Implement MiniGameLightningGameController
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
            audioPlayer = await audioCache.play('spirit_realms.mp3');
            Future.delayed(Duration(milliseconds: 100), () async {
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

    audioCache.play('spirit_realms.mp3');
    super.onInit();
  }
}
