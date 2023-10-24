import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoDetailController extends GetxController {
  //TODO: Implement GalleryVideoDetailController

  final Map<String, dynamic> arguments = Get.arguments;
  late VideoPlayerController videoController;

  @override
  void onInit() {
    super.onInit();
    print(arguments['video']);
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(arguments['video']))
          ..initialize().then((_) {
            videoController.play(); // Start playing the video
            update();
          });
  }

  @override
  void onClose() {
    videoController
        .dispose(); // Dispose of the video controller when not needed
    super.onClose();
  }
}
