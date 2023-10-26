import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameHumbabaController extends GetxController {
  RxBool isFinished = false.obs;
  final AudioCache audioCache =
      AudioCache(prefix: 'assets/audios/pregames/night_sounds/');
  AudioPlayer audioPlayer = AudioPlayer();
  Rx<String> audioFile = Rx<String>("");
  RxBool showButtons = true.obs;
  RxString key_tuts = ''.obs;
  int lockCode = 123456;
  int maxDigits = 6;
  RxBool doneGame = true.obs;
  RxBool scrollBg = true.obs;
  RxBool openTreeLeft = false.obs;
  RxBool openTreeRight = false.obs;
  RxBool showBeast = false.obs;
  RxBool blackScreen = false.obs;
  RxBool playAnimation = false.obs;
  RxBool isStartAnimation = false.obs;

  Rx<int> currentTimer = Rx<int>(0);
  RxInt selectedImageIndex = RxInt(-1);
  int tickCount = 0;

  RxString audio1 = RxString("");
  RxString audio2 = RxString("");
  RxString audio3 = RxString("");

  Future<void> playAudio(String audioFileName) async {
    audioPlayer = await audioCache.play(audioFileName);
  }

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    Vibration.vibrate(duration: 1000);
    playAudio("1. hoembaba stem.wav");

    super.onInit();
  }

  void startAnimation() {
    if (!isStartAnimation.value) {
      isStartAnimation.value = true;
      Future.delayed(Duration(seconds: 2), () {
        showBeast.value = true;
        Future.delayed(Duration(seconds: 3), () async {
          blackScreen.value = true;
          playAudio("hoembaba-lange-toon.wav");
        });
      });
    }
  }

  @override
  void onClose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.onClose();
  }
}
