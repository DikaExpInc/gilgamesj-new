import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vibration/vibration.dart';

class TheaterGameStarTimerGameController extends GetxController {
  //TODO: Implement TheaterGameStarTimerGameController

  RxString selectedAction = "".obs;
  AudioPlayer? audioPlayer;
  final AudioCache audioCache =
      AudioCache(prefix: 'assets/audios/pregames/night_sounds/');

  @override
  Future<void> onInit() async {
    super.onInit();
    Vibration.vibrate(duration: 1000);

    initializeAudioPlayer();

    // Update player number
    int playedNumber = GetStorage().read('played_number') ?? 0;
    int totalPlayer = int.parse(GetStorage().read('totalPlayer'));
    if (playedNumber + 1 >= totalPlayer) {
      GetStorage().write('played_number', 0);
    } else {
      GetStorage().write('played_number', playedNumber + 1);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    audioPlayer?.stop();
    super.onClose();
  }

  // Fungsi untuk inisialisasi audio player
  Future<void> initializeAudioPlayer() async {
    audioPlayer = await audioCache.play('Alarm.mp3');
    audioPlayer?.onPlayerCompletion.listen((event) async {
      if (selectedAction.value == "") {
        initializeAudioPlayer();
      } else {
        if (selectedAction.value == "Snooze") {
          initializeAudioPlayer();
        } else {
          Get.offNamed(Routes.THEATER_GAME_STAR_GAME_DONE);
        }
      }
    });
  }
}
