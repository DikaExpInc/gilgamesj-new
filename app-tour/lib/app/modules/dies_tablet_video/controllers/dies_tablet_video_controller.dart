import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

class DiesTabletVideoController extends GetxController {
  VideoPlayerController? videocontroller;

  @override
  void onInit() {
    Vibration.vibrate(duration: 1000);
    videocontroller =
        VideoPlayerController.asset('assets/videos/dead_tablet.mp4');
    videocontroller?.initialize().then((_) {
      videocontroller!.play();
      update();
    });
    super.onInit();
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
