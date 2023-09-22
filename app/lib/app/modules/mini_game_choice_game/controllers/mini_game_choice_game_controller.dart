import 'package:app/app/data/question_model.dart';
import 'package:app/app/modules/mini_game_choice_game/views/screens/choice_game_message_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

class MiniGameChoiceGameController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerParticle;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;
  final List<Question> questions = [
    Question('assets/images/question1-1', 'assets/images/question1-2',
        'Wringkle Bearers', 'Elderly'),
    Question('assets/images/question2-1', 'assets/images/question2-2',
        'Pinch Bottom', 'Remain Silent'),
    Question('assets/images/question3-1', 'assets/images/question3-2',
        'Friend Stealer', 'Sweethearts'),

    // Tambahkan pertanyaan lainnya sesuai kebutuhan
  ];
  final RxInt currentIndex = 0.obs;

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
    setWidget(ChoiceGameMessageScreen());
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

    super.onInit();
  }

  void goToNextQuestion() {
    characterSelect.value = "";
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    }
  }

  bool isLastQuestion() {
    return currentIndex.value == questions.length - 1;
  }
}
