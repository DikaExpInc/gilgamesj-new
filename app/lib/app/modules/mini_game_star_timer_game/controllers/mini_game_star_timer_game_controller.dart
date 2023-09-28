import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class MiniGameStarTimerGameController extends GetxController {
  //TODO: Implement MiniGameStarTimerGameController

  RxString selectedAction = "".obs;
  AudioPlayer? audioPlayer;
  final AudioCache audioCache =
      AudioCache(prefix: 'assets/audios/pregames/night_sounds/');

  @override
  Future<void> onInit() async {
    super.onInit();
    Vibration.vibrate(duration: 1000);

    audioPlayer = await audioCache.play('Alarm.mp3');
    audioPlayer?.onPlayerCompletion.listen((event) async {
      if (selectedAction.value == "") {
        audioPlayer = await audioCache.play('Alarm.mp3');
      } else {
        if (selectedAction.value == "Snooze") {
          audioPlayer = await audioCache.play('Alarm.mp3');
        } else {
          Get.offNamed(Routes.MINI_GAME_STAR_GAME_DONE);
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
