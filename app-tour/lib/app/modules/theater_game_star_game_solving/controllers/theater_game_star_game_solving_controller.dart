import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class TheaterGameStarGameSolvingController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isFinished = false.obs;
  final AudioCache audioCache =
      AudioCache(prefix: 'assets/audios/pregames/night_sounds/');
  // final AudioCache audioCache2 = AudioCache(prefix: 'assets/audios/');
  AudioPlayer audioPlayer = AudioPlayer();
  Rx<String> audioFile = Rx<String>("");
  RxBool showButtons = true.obs;
  RxString key_tuts = ''.obs;
  int lockCode = 123456;
  int maxDigits = 6;
  RxBool doneGame = false.obs;

  RxBool scrollBg = false.obs;
  RxBool openTreeLeft = false.obs;
  RxBool openTreeRight = false.obs;
  RxBool showBeast = false.obs;
  RxBool blackScreen = false.obs;
  RxBool playAnimation = false.obs;

  Rx<int> currentTimer = Rx<int>(0);
  RxInt selectedImageIndex = RxInt(-1);
  int tickCount = 0;

  RxString audio1 = RxString("");
  RxString audio2 = RxString("");
  RxString audio3 = RxString("");

  // Method untuk memainkan audio
  Future<void> playAudio(String audioFileName) async {
    audioPlayer.stop();
    audioPlayer = await audioCache.loop(audioFileName);
  }

  @override
  void onClose() {
    audioPlayer.stop();
    super.onClose();
  }

  @override
  void onInit() {
    // Di sini Anda dapat mengatur widget awal yang akan ditampilkan
    Vibration.vibrate(duration: 1000);
    super.onInit();
  }

  void increment(int inkWellIndex) {
    String currentCode = '${key_tuts.value}$inkWellIndex';
    if (lockCode.toString().startsWith(currentCode)) {
      if (key_tuts.value.length == 0) {
        key_tuts.value = '$inkWellIndex'; // Pertama kali input
      } else {
        // Input yang sesuai dengan kode
        key_tuts.value = currentCode;
        if (currentCode == lockCode.toString()) {
          doneGame.value = true;
          Future.delayed(Duration(seconds: 3), () {
            scrollBg.value = true;
          });
        }
      }
    } else {
      key_tuts.value = '';
    }
  }

  bool isNumberPresentInString(int numberToCheck) {
    List<String> digits = key_tuts.value.split('');
    return digits.contains(numberToCheck.toString());
  }

  void startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      showBeast.value = true;
      Future.delayed(Duration(seconds: 3), () {
        blackScreen.value = true;
        audioCache.play("fang.mp3");
        Future.delayed(Duration(seconds: 5), () {
          Get.offNamed(
            Routes.THEATER_GAME_STAR_TIMER_GAME,
          );
        });
      });
    });
  }
}
