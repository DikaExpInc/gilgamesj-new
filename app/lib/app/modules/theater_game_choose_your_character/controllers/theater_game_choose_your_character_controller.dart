import 'dart:async';
import 'dart:math';

import 'package:app/app/modules/theater_game_choose_your_character/views/screens/choose_game_character_screen.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';

class TheaterGameChooseYourCharacterController extends GetxController
    with GetTickerProviderStateMixin {
  RxDouble containerWidth = 1200.0.obs;
  Timer? timer;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  // RxBool isShaking = false.obs;

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
    // shakeDetector!.stopListening();
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
    setWidget(TheaterGameChooseCharacterScreen());
    // startAutomaticChange();
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
    // setWidget(TheaterGameChooseYourCharMessageScreen());
    setWidget(TheaterGameChooseCharacterScreen());
    startAutomaticChange();

    Vibration.vibrate(duration: 1000);

    sub = settingStream.listen((event) {
      changeBackgroundColor();
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
      stopAutomaticChange();
      GetStorage().write('status_seat_tablet', characterSelect);

      Get.offNamed(Routes.THEATER_GAME_CHOOSE_YOUR_CHARACTER_DONE,
          arguments: {"selected": characterSelect});
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
    audioCache.play('confirm.mp3');
    stopAutomaticChange();
    GetStorage().write('status_seat_tablet', characterSelect);
    Get.offNamed(Routes.THEATER_GAME_CHOOSE_YOUR_CHARACTER_DONE,
        arguments: {"selected": characterSelect});
  }
}
