import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController {
  @override
  void onInit() {
    final AudioCache audioCache = AudioCache(prefix: 'assets/audios/');
    audioCache.play('first_sound.mp3');
    super.onInit();
  }
}
