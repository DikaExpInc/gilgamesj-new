import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

class LightningController extends GetxController {
  VideoPlayerController? videocontroller;

  @override
  void onInit() {
    super.onInit();
    Vibration.vibrate(duration: 1000);
    videocontroller =
        VideoPlayerController.asset('assets/videos/thundercloud.mp4');
    videocontroller?.setLooping(true); // This will make the video loop
    videocontroller?.initialize().then((_) {
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
    videocontroller?.dispose();
    super.onClose();
  }
}
