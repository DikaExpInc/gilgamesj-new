import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class MiniGameStarGameSolvingController extends GetxController
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

    // final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
    // audioCache.play('spirit_realms.mp3');

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
          // Get.offNamed(Routes.PRE_GAME_SUCCESS);
          doneGame.value = true;
          Future.delayed(Duration(seconds: 5), () {
            audioPlayer.stop();
            Get.offAllNamed(Routes.MINI_GAME_STAR_TIMER_GAME);
          });
        }
      }
    } else {
      key_tuts.value = '';
    }
  }

  void reset() {
    key_tuts.value = '';
  }

  bool isNumberPresentInString(int numberToCheck) {
    List<String> digits = key_tuts.value.split('');
    return digits.contains(numberToCheck.toString());
  }
}
