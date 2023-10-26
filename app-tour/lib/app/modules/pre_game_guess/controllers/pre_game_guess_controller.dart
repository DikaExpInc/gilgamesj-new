import 'package:app/app/data/guess_model.dart';
import 'package:app/app/modules/pre_game_guess/views/screens/guess_game_main_screen.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';

class PreGameGuessController extends GetxController {
  RxBool isFinished = false.obs;
  final Map<String, dynamic> arguments = Get.arguments;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

  RxString time = "00:00".obs;
  RxString idleTime = "00:00".obs;
  RxString characterSelect = "".obs;
  RxBool isIdleTimerRunning = false.obs;
  bool isRunning = false;
  final RxInt currentIndex = 0.obs;
  final List<Guess> questions = [];
  final RxString titleGame = "".obs;
  final RxString imageGame = "".obs;

  // onTap Loading
  final RxDouble tapValue = 0.0.obs;
  RxBool tapStatus = false.obs;

  @override
  void onClose() {
    super.onClose();
  }

  void stopTapLoading() {
    tapStatus.value = false;
    tapValue.value = 0;
  }

  late Widget selectedWidget;

  // Buat sebuah metode untuk mengatur widget yang akan dipanggil
  void setWidget(Widget widget) {
    selectedWidget = widget;
    update(); // Memaksa pembaruan tampilan
  }

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    // setWidget(ChatandCallGameMessageScreen());
    setWidget(GuessGameMainScreen());
    Vibration.vibrate(duration: 1000);
    if (arguments['game'] == 'game5') {
      titleGame.value =
          "Je gaat naar een bos met een reusachtig, angstaanjagend wezen";
      imageGame.value = "assets/images/pregame5-main.png";
      questions.add(Guess(
        'assets/images/pregame5-q1.png',
        'Het beest met je wil vechten?',
        'Ik zou vechten met woorden',
        'Ik zou vechten met wapens',
      ));
      questions.add(Guess(
        'assets/images/pregame5-q2.png',
        'Je beste vriend ineens heel bang is?',
        'Ik zou alleen vechten',
        'Ik zou mijn beste vriend overtuigen om mee te vechten',
      ));
      questions.add(Guess(
        'assets/images/pregame5-q3.png',
        'Je het angstaanjagende beest vermoord?',
        'Ik zou zijn hoofd op een stok spiezen en ermee rondrennen',
        'Ik zou het beest begraven en een lied zingen',
      ));
    }
    if (arguments['game'] == 'game6') {
      titleGame.value =
          "Je bent het stoerste kind ter wereld en je beste vriend wordt smoorverliefd op je. ";
      imageGame.value = "assets/images/pregame7-main.png";
      questions.add(Guess(
        'assets/images/pregame7-q1.png',
        'Je voelt dat je beste vriend verliefd op je is',
        'Ik zou zeggen dat ik dat voel',
        'Ik zou net doen alsof er niets aan de hand is',
      ));
      questions.add(Guess(
        'assets/images/pregame7-q2.png',
        'Je beste vriend je een kus wil geven',
        'Ik zou wegrennen',
        'Ik zou een kus terug geven',
      ));
      questions.add(Guess(
        'assets/images/pregame7-q3.png',
        'Je beste vriend boos is omdat jij niet wil',
        'Ik zou diegene troosten',
        'Ik zou mijn schouders ophalen',
      ));
    }
    if (arguments['game'] == 'game7') {
      titleGame.value =
          "Je bent het stoerste kind ter wereld en je beste vriend wordt smoorverliefd op je.";
      imageGame.value = "assets/images/pregame7-main.png";
      questions.add(Guess(
        'assets/images/pregame7-q1.png',
        'Je voelt dat je beste vriend verliefd op je is',
        'zeggen dat je dat voelt',
        'het negeren',
      ));
      questions.add(Guess(
        'assets/images/pregame7-q2.png',
        'Je beste vriend je een kus wil geven',
        'wegrennen',
        'een kus terug geven',
      ));
      questions.add(Guess(
        'assets/images/pregame7-q3.png',
        'Je beste vriend boos is omdat jij niet wil',
        'diegene troosten',
        'schouders ophalen',
      ));
    }
    super.onInit();
  }

  void goToNextQuestion() {
    audioCache.play('select2.mp3');
    if (currentIndex.value < questions.length - 1) {
      characterSelect.value = "";
      currentIndex.value++;
    } else {
      int playedNumber = GetStorage().read('played_number') ?? 0;
      int totalPlayer = int.parse(GetStorage().read('totalPlayer'));
      if (playedNumber + 1 >= totalPlayer) {
        GetStorage().write('played_number', 0);
      } else {
        GetStorage().write('played_number', playedNumber + 1);
      }
      onSubmit();
    }
  }

  Future<void> onSubmit() async {
    GetStorage().write('pre-game-${arguments['id']}', 'ada');
    Get.offAllNamed(Routes.PRE_GAME_SUCCESS);
  }
}
