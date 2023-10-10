import 'dart:async';
import 'dart:math';

import 'package:app/app/modules/theater_game_lightning_game_custom/views/screens/lightning_game_custom_light_screen.dart';
import 'package:app/app/modules/theater_game_lightning_game_custom/views/screens/lightning_game_custom_message_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

class TheaterGameLightningGameCustomController extends GetxController
    with GetTickerProviderStateMixin {
  ShakeDetector? shakeDetector;
  RxDouble containerWidth = 1200.0.obs;
  Timer? timer;
  final Map<String, dynamic> arguments = Get.arguments;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  // animation text
  late final AnimationController _controllerText;
  late final Animation<double> _animationText;

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
    _controllerText.dispose();
    shakeDetector!.stopListening();
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
    setWidget(LightningGameCustomLightScreen());
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

  Animation<double> get animation => _animationText;

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
    setWidget(LightningGameCustomMessageScreen());
    Vibration.vibrate(duration: 1000);

    sub = settingStream.listen((event) {
      changeBackgroundColor();
    });

    shakeDetector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1.5,
        onPhoneShake: () async {
          if (!isShaking.value) {
            isShaking.value = true;
            // try {
            //   await TorchLight.enableTorch();
            // } on EnableTorchExistentUserException catch (e) {
            //   //camera in use
            //   print("camera in use");
            // } on EnableTorchNotAvailableException catch (e) {
            //   //torch not available
            //   print("torch not available");
            // } on EnableTorchException catch (e) {
            //   //something went wrong
            //   print("something went wrong");
            // }
            Future.delayed(Duration(milliseconds: 1000), () async {
              isShaking.value = false;
              // try {
              //   await TorchLight.disableTorch();
              // } on DisableTorchExistentUserException catch (e) {
              //   //camera in use
              //   print("camera in use");
              // } on DisableTorchNotAvailableException catch (e) {
              //   //torch not available
              //   print("torch not available");
              // } on DisableTorchException catch (e) {
              //   //something went wrong
              //   print("something went wrong");
              // }
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

    super.onInit();
  }

  void stopAutomaticChange() {
    if (timer != null && timer!.isActive) {
      timer!.cancel(); // Membatalkan timer jika sedang berjalan
    }
  }

  final Stream settingStream =
      Stream.periodic(const Duration(milliseconds: 400), (int count) {
    return count;
  });
  late StreamSubscription sub;

  final List<Color> backgroundColors = [
    Colors.white,
    Colors.black,
  ];
  var currentColorIndex = 0.obs;

  void changeBackgroundColor() {
    currentColorIndex.value =
        (currentColorIndex.value + 1) % backgroundColors.length;
  }
}
