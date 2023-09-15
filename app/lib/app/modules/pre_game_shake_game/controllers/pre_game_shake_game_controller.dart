import 'package:app/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:video_player/video_player.dart';
import 'package:vibration/vibration.dart';

class PreGameShakeGameController extends GetxController {
  ShakeDetector? shakeDetector;
  VideoPlayerController? videocontroller;
  RxBool isShaking = false.obs;
  RxBool isDone = false.obs;
  int lockCode = 3142;
  RxString key_tuts = ''.obs;
  int maxDigits = 4;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

  void increment(int inkWellIndex) {
    if (key_tuts.value.length < maxDigits - 1) {
      key_tuts.value = '${key_tuts.value}$inkWellIndex';
    } else {
      key_tuts.value = '${key_tuts.value}$inkWellIndex';
      String lockCodeString = lockCode.toString();
      print("key_tuts : ${key_tuts.value}");
      print("lockCode : ${lockCodeString}");
      if (lockCodeString == key_tuts.value) {
        // audioCache.play('spirit_realms.mp3');
        // showItemDialog(title: 'Waauw', description: 'Het is je gelukt !!');
        Get.offNamed(Routes.PRE_GAME_SUCCESS);
      } else {
        audioCache.play('error-glitch.mp3');
      }
      reset();
    }
  }

  void reset() {
    key_tuts.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    Vibration.vibrate(duration: 1000);
    shakeDetector = ShakeDetector.autoStart(
        shakeThresholdGravity: 1.5,
        onPhoneShake: () {
          if (!isShaking.value) {
            videocontroller!.play();
            isShaking.value = true;
            Future.delayed(Duration(seconds: 2), () {
              videocontroller!.pause();
              isShaking.value = false;
            });
          }
        });
    videocontroller = VideoPlayerController.asset('assets/videos/sand.mp4');
    videocontroller!.addListener(() {
      if (videocontroller!.value.position >= videocontroller!.value.duration) {
        isDone.value = true;
      }
    });

    videocontroller!.initialize().then((_) {
      update();
    });
  }
}
