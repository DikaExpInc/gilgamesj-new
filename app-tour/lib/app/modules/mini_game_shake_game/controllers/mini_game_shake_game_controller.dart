import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shake/shake.dart';
import 'package:video_player/video_player.dart';
import 'package:vibration/vibration.dart';

class MiniGameShakeGameController extends GetxController {
  Map<String, dynamic> arguments = Get.arguments;
  ShakeDetector? shakeDetector;
  VideoPlayerController? videocontroller;
  RxBool isShaking = false.obs;
  RxBool isDone = false.obs;
  int lockCode = 3142;
  RxString key_tuts = ''.obs;
  int maxDigits = 4;
  final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

  void increment(int inkWellIndex) {
    String currentCode = '${key_tuts.value}$inkWellIndex';
    if (lockCode.toString().startsWith(currentCode)) {
      audioCache.play('sparkle.mp3');
      if (key_tuts.value.length == 0) {
        key_tuts.value = '$inkWellIndex'; // Pertama kali input
      } else {
        // Input yang sesuai dengan kode
        key_tuts.value = currentCode;
        if (currentCode == lockCode.toString()) {
          Get.offNamed(Routes.PRE_GAME_SUCCESS);
        }
      }
    } else {
      key_tuts.value = '';
      audioCache.play('wrong-answer.mp3');
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
        shakeThresholdGravity: 1.3,
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
        if (arguments['game'] != "rule") {
          isDone.value = true;
        } else {
          shakeDetector!.stopListening();
          videocontroller!.pause();
          Future.delayed(Duration(seconds: 5), () {
            int playedNumber = GetStorage().read('played_number') ?? 0;
            int totalPlayer = int.parse(GetStorage().read('totalPlayer'));
            if (playedNumber + 1 >= totalPlayer) {
              GetStorage().write('played_number', 0);
            } else {
              GetStorage().write('played_number', playedNumber + 1);
            }
            GetStorage().write('pre-game-${arguments['id']}', 'ada');
            Get.offAllNamed(Routes.PRE_GAME_SUCCESS);
          });
        }
      }
    });

    videocontroller!.initialize().then((_) {
      update();
    });
  }

  @override
  void onClose() {
    shakeDetector!.stopListening();
    super.onClose();
  }

  bool isNumberPresentInString(int numberToCheck) {
    List<String> digits = key_tuts.value.split('');
    return digits.contains(numberToCheck.toString());
  }
}
