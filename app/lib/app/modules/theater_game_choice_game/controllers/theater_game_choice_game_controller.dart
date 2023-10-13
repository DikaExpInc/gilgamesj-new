import 'dart:async';

import 'package:app/app/data/question_model.dart';
import 'package:app/app/modules/theater_game_choice_game/views/screens/choice_game_character_screen.dart';
import 'package:app/app/modules/theater_game_choice_game/views/screens/choice_game_message_screen.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/game5_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameChoiceGameController extends GetxController
    with GetTickerProviderStateMixin {
  final Map<String, dynamic> arguments = Get.arguments;

  RxDouble containerWidth = 1200.0.obs;
  Timer? timer;
  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;
  // final List<Question> questions = [
  //   Question('assets/images/question1-1', 'assets/images/question1-2',
  //       'Wringkle Bearers', 'Elderly'),
  //   Question('assets/images/question2-1', 'assets/images/question2-2',
  //       'Pinch Bottom', 'Remain Silent'),
  //   Question('assets/images/question3-1', 'assets/images/question3-2',
  //       'Friend Stealer', 'Sweethearts'),
  final List<Question> questions = [];

  final RxInt currentIndex = 0.obs;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  @override
  void onClose() {
    _controller.dispose();
    _controllerParticle.dispose();
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
    setWidget(ChoiceGameCharacterScreen());
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
    // setWidget(ChoiceGameMessageScreen());
    setWidget(ChoiceGameCharacterScreen());
    startAutomaticChange();
    firstInit();

    Vibration.vibrate(duration: 1000);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();

    _controllerParticle = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    if (arguments['game'] == 'underwear') {
      questions.add(Question(
        'assets/images/question-1',
        'assets/images/question-2',
        'Zijn zwaard',
        'Zijn vieze onderbroeken',
      ));
    }
    if (arguments['game'] == 'sick') {
      questions.add(Question(
        'assets/images/sick-enkidu-yes',
        'assets/images/sick-enkidu-no',
        'Yes',
        'No',
      ));
    }

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
      goToNextQuestion();
    }
  }

  void goToNextQuestion() {
    characterSelect.value = "";
    if (currentIndex.value < questions.length - 1) {
      containerWidth.value = 1200.0;
      currentIndex.value++;
    } else {
      onSubmit();
    }
  }

  bool isLastQuestion() {
    return currentIndex.value == questions.length - 1;
  }

  Future<void> onSubmit() async {
    stopAutomaticChange();
    String id = "";
    if (characterSelect == "Zijn vieze onderbroeken") {
      id = "65274e4d596123a74cb5dec1";
    } else {
      id = "65274e6c596123a74cb5dec2";
    }
    audioCache.play('confirm.mp3');
    String choice = await Game5Api().voteAPI(id);
    if (choice == "done") {
      Get.toNamed(Routes.THEATER_GAME_CHOICE_GAME_DONE);
    }
  }

  Future<void> firstInit() async {
    await Game5Api().resetAPI();
  }
}
