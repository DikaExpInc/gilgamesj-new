import 'dart:async';

import 'package:app/app/data/question_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameTabletDiesController extends GetxController
    with GetTickerProviderStateMixin {
  RxDouble containerWidth = 1200.0.obs;
  Timer? timer;
  RxBool isFinished = false.obs;
  RxString characterSelect = "".obs;
  RxBool isShaking = false.obs;
  RxBool isGlitch = false.obs;
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
    super.onClose();
  }

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    // setWidget(ChoiceGameMessageScreen());
    // startAutomaticChange();

    Vibration.vibrate(duration: 1000);

    questions.add(Question(
      'assets/images/sick-enkidu-yes',
      'assets/images/sick-enkidu-no',
      'Yes',
      'No',
    ));

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
    }
  }

  bool isLastQuestion() {
    return currentIndex.value == questions.length - 1;
  }
}
