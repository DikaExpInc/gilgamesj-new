import 'package:app/app/modules/mini_game_lightning_game/views/screens/lightning_game_message_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';
import 'package:torch_light/torch_light.dart';

class MiniGameLightningGameController extends GetxController
    with GetTickerProviderStateMixin {
  ShakeDetector? shakeDetector;

  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;

  // animation text
  late final AnimationController _controllerText;
  late final Animation<double> _animationText;

  @override
  void onClose() {
    super.onClose();
    _controller.dispose();
    _controllerParticle.dispose();
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

  Animation<double> get animation => _animationText;

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
    setWidget(LightningGameMessageScreen());
    Vibration.vibrate(duration: 1000);

    shakeDetector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1.5,
        onPhoneShake: () async {
          if (!isShaking.value) {
            isShaking.value = true;
            try {
              await TorchLight.enableTorch();
            } on EnableTorchExistentUserException catch (e) {
              //camera in use
              print("camera in use");
            } on EnableTorchNotAvailableException catch (e) {
              //torch not available
              print("torch not available");
            } on EnableTorchException catch (e) {
              //something went wrong
              print("something went wrong");
            }
            Future.delayed(Duration(milliseconds: 100), () async {
              isShaking.value = false;
              try {
                await TorchLight.disableTorch();
              } on DisableTorchExistentUserException catch (e) {
                //camera in use
                print("camera in use");
              } on DisableTorchNotAvailableException catch (e) {
                //torch not available
                print("torch not available");
              } on DisableTorchException catch (e) {
                //something went wrong
                print("something went wrong");
              }
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

    _controllerText = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _animationText = Tween<double>(begin: 300, end: 0).animate(_controllerText);

    final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
    audioCache.play('spirit_realms.mp3');
    super.onInit();
  }
}
