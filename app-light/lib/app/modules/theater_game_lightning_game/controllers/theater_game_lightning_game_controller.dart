import 'dart:async';
import 'dart:math';

import 'package:app/app/modules/theater_game_lightning_game/views/screens/lightning_game_character_screen.dart';
import 'package:app/app/modules/theater_game_lightning_game/views/screens/lightning_game_light_screen.dart';
import 'package:app/app/modules/theater_game_lightning_game/views/screens/lightning_game_message_screen.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/game2_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

class TheaterGameLightningGameController extends GetxController
    with GetTickerProviderStateMixin {
  ShakeDetector? shakeDetector;
  RxDouble containerWidth = 1200.0.obs;
  Timer? timer;
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
    stopAutomaticChange();
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
    // setWidget(LightningGameCharacterScreen());
    Get.offNamed(Routes.THEATER_GAME_LIGHTNING_GAME_DONE);
    startAutomaticChange();
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
    // setWidget(LightningGameMessageScreen());
    setWidget(LightningGameCharacterScreen());
    startAutomaticChange();
    firstInit();
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

  void startAutomaticChange() {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      toggleContainerWidth();
    });
  }

  void stopAutomaticChange() {
    if (timer != null && timer!.isActive) {
      timer!.cancel(); // Membatalkan timer jika sedang berjalan
    }
  }

  void toggleContainerWidth() {
    containerWidth.value -= 10.0;
    if (containerWidth.value < 0) {
      containerWidth.value = 1200.0;
      selectRandomCharacter();
      onSubmit();
    }
  }

  void selectRandomCharacter() {
    final List<String> characters = ["Gilgamesh", "Enkidu"];
    final Random random = Random();
    final int randomIndex = random.nextInt(characters.length);
    characterSelect.value = characters[randomIndex];
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

  Future<void> onSubmit() async {
    stopAutomaticChange();
    String id = "";
    if (characterSelect == "Enkidu") {
      id = "65273ad7596123a74cb5debb";
    } else {
      id = "65273ac6596123a74cb5deba";
    }
    audioCache.play('confirm.mp3');
    String choice = await Game2Api().voteAPI(id);
    if (choice == "done") {
      Get.toNamed(Routes.THEATER_GAME_LIGHTNING_GAME_DONE);
    }
  }

  Future<void> firstInit() async {
    await Game2Api().resetAPI();
  }
}
