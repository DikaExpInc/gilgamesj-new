import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

class LightningController extends GetxController {
  VideoPlayerController? videocontroller;
  RxBool isDone = false.obs;

  @override
  void onInit() {
    super.onInit();
    Vibration.vibrate(duration: 1000);

    videocontroller =
        VideoPlayerController.asset('assets/videos/thundercloud.mp4');

    videocontroller!.addListener(() {
      if (videocontroller!.value.position >= videocontroller!.value.duration) {
        isDone.value = true;
      }
    });

    videocontroller!.initialize().then((_) {
      videocontroller!.play();
      update();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    videocontroller!.pause();
    super.onClose();
  }
}
