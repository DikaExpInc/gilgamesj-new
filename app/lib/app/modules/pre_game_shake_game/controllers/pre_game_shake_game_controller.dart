import 'package:get/get.dart';
import 'package:shake/shake.dart';
import 'package:video_player/video_player.dart';

class PreGameShakeGameController extends GetxController {
  ShakeDetector? shakeDetector;
  VideoPlayerController? videocontroller;
  RxBool isShaking = false.obs;
  RxBool isDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
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
